class ServicesController < ApplicationController
  before_action :initialize_service, only: :show
  before_action :initialize_page_banner
  def index
    @services = Service.published.sort_by_sorting_position

    @page_banner = {
        bg_image: 'banners/services.jpg',
        title: "Expertise",
        number: "08",
        number_description: "fields of expertise",
        scroll_down_title: "view all"
    }

  end

  def show
    if @service
      @page_banner = {
          bg_image: 'banners/services.jpg',
          title: @service.name,
          number: "08",
          number_description: "cases",
          scroll_down_title: "read more"
      }
    end
  end

  private
  def initialize_service
    @service = Service.published.joins(:translations).where(service_translations: { url_fragment: params[:id], locale: params[:locale] } ).first
  end

  def initialize_page_banner

  end
end