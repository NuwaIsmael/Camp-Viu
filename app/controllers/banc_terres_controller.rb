class BancTerresController < BaseController
  layout 'darkswarm'

  before_action :enable_embedded_shopfront

  def index
    @langvar = I18n.locale
    if ContentConfig.home_show_stats
      @num_distributors = cached_count('distributors', Enterprise.is_distributor.activated.visible)
      @num_producers = cached_count('producers', Enterprise.is_primary_producer.activated.visible)
      @num_products = 0
    end
  end

  def sell; end

  def unauthorized
    render 'shared/unauthorized', status: :unauthorized
  end

  private

  # Cache the value of the query count
  def cached_count(statistic, query)
    CacheService.home_stats(statistic) do
      query.count
    end
  end
end
