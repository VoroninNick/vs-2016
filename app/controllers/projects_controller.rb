class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  def index
    set_services
    set_projects_banner
    set_page_metadata("projects")
    @projects = @popup_projects

  end

  def category

  end

  def show

    if @project
      set_page_metadata(@project)
      @theme = @project.code_name
      render "projects/templates/#{@project.code_name}"
    else
      set_category
      if @category
        set_services
        set_projects_banner
        set_page_metadata(@category)
        @projects = @category.projects.published
        render "index"
      else
        render_not_found
      end
    end
  end

  def set_services
    @services = Service.published.sort_by_sorting_position
  end

  def set_projects_banner
    last_created_at = @popup_projects.order("created_at desc").first.created_at
    days_last_added = 31

    @page_banner = {
        bg_image: 'banners/services.jpg',
        title: "Portfolio",
        numbers: [
            {number: @popup_projects.count, number_description: "projects"},
            {number: @services.count, number_description: "categories"},
            {number: days_last_added, number_description: "days last added"}
        ],
        scroll_down_title: "view all"
    }
  end

  def set_category
    @category = Service.translation_class.where(url_fragment: params[:id], locale: I18n.locale).first.try{|t| Service.find(t.service_id) }
  end

  def set_project
    @project = Project.translation_class.where(url_fragment: params[:id], locale: I18n.locale).first.try{|t| Project.find(t.project_id) }
    if !@project
      return
    end
    project_translation = @project.translations_by_locale[I18n.locale]
    @project_banner = {
        title: project_translation.banner_title,
        title_sup: project_translation.banner_title_sup,
        short_description: project_translation.short_description,
        image_url: @project.item_top_banner_image.url
    }

    @project_banner[:bg_image_url] = @project.item_top_banner_bg_image.url if @project.item_top_banner_bg_image.exists?
  end
end
