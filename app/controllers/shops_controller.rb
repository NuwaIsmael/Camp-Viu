class ShopsController < BaseController
  layout 'darkswarm'

  before_action :enable_embedded_shopfront

  def index
    @enterprises = Enterprise.where("NOT is_primary_producer = false AND sells = 'any'")
  end
end
