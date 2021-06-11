class BancTerresController < BaseController
  layout 'darkswarm'

  before_action :enable_embedded_shopfront

  def index
    @langvar = I18n.locale
    if ContentConfig.home_show_stats
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
