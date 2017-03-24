class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include ActionView::Helpers::OutputSafetyHelper
  include Cms::Helpers::ImageHelper
  include ActionView::Helpers::AssetUrlHelper
  include Cms::Helpers::UrlHelper


  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::TagHelper
  include Cms::Helpers::PagesHelper
  extend Cms::Helpers::PagesHelper::ClassMethods
  include Cms::Helpers::MetaDataHelper
  include Cms::Helpers::NavigationHelper
  include FormsHelper
  include ApplicationHelper

  if ENV["developer_machine"] == "pasha.home"
    include AssetPathHelper
  end

  before_action do
    #sleep(4)
  end

  before_action :set_locale, unless: :admin_panel?
  before_action :set_popup_projects
  before_action :set_forms_popups

  # if Rails.env.development?
  #   before_action :reload_translations
  # end

  def ajax?
    params[:ajax] || request.path.start_with?("/ajax/")
  end

  if Rails.env.development?
    before_action do
      if admin_panel?

        RailsAdminDynamicConfig.configure_rails_admin(false)
      end
    end
  end

  def root_without_locale
    redirect_to root_path(locale: I18n.locale)
  end

  def default_url_options
    if controller_name == "file_editor"
      return {}
    end

    {locale: I18n.locale}
  end

  def render_not_found
    render template: "errors/not_found.html.slim", layout: false, status: 404
  end

  def set_locale
    I18n.locale = params[:locale]
  end

  def admin_panel?
    admin = params[:controller].to_s.starts_with?("rails_admin")

    return admin
  end

  def set_popup_projects
    @popup_projects = Project.published.includes(translations: [], services: [:translations]).sort_by_sorting_position
    @ordered_project_ids = Project.ordered_project_ids
  end

  def set_forms_popups
    @hire_us_form = HireUsRequest.new
    @join_us_form = JoinUsRequest.new
  end
end
