class ServicesController < ApplicationController
  before_action :initialize_services, only: [:index, :show]
  before_action :initialize_service, only: :show
  before_action :initialize_page_banner
  caches_page :index, :show
  def index

    set_page_metadata("services")
    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-expertise.jpg',
        title: t("services.index.banner.title"),
        numbers: [
          { number: "08", number_description: t("services.index.banner.fields-of-experise")}
        ],
        scroll_down_title: "view all"
    }

  end

  def show
    if @service
      set_page_metadata(@service)
      @page_banner = {
          bg_image: 'banners/inner-page-main-banners-v1-expertise.jpg',
          title: @service.name,
          numbers: [
              {number: "08", number_description: t("services.show.banner.cases")}
          ],
          scroll_down_title: "read more"
      }

      @related_projects = @service.projects.published
    end
  end

  private
  def initialize_services
    @services = Service.published.sort_by_sorting_position.includes(:translations)
  end

  def initialize_service
    @service = Service.published.joins(:translations).where(service_translations: { url_fragment: params[:id], locale: params[:locale] } ).first
  end

  def initialize_page_banner

  end
end