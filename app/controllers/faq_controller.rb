class FaqController < BaseController
  layout 'darkswarm'

  before_action :enable_embedded_shopfront

  def index
    @langvar = I18n.locale
  end

  def sell; end

  def unauthorized
    render 'shared/unauthorized', status: :unauthorized
  end
  
end
