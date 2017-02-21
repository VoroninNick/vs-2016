class ProjectsController < ApplicationController
  before_action
  before_action :set_project, only: [:show]
  caches_page :index, :show

  def index
    set_services
    set_projects_banner
    set_page_metadata("projects")
    initialize_projects
    set_navigation_links(Project.first)
    if ajax?
      render "_projects.html", layout: false
    end

  end

  def show
    init_shuvar_info
    if @project
      set_page_metadata(@project)
      @theme = @project.code_name
      theme_template_path = "projects/templates/#{@theme}"
      set_navigation_links(@project)
      initialize_projects
      if template_exists?(theme_template_path)
        render theme_template_path
      else
        render "show"
      end
    else
      set_category
      if @category
        set_services
        set_projects_banner
        set_page_metadata(@category)
        @projects = @category.projects.published
        if ajax?
          render "_projects.html", layout: false
        else
          render "index"
        end

      else
        render_not_found
      end
    end
  end

  protected

  def category

  end

  def set_services
    @services = Service.published.sort_by_sorting_position.joins(:projects).where(projects: { published: 't' })
    #@service = @services.first
  end

  def set_projects_banner
    last_created_at = @popup_projects.order("created_at desc").first.created_at
    days_last_added = 31

    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-portfolio.jpg',
        title: "Portfolio",
        numbers: [
            {number: @popup_projects.count, number_description: "projects"},
            {number: @services.count, number_description: "categories"},
            {number: days_last_added, number_description: "days last added"}
        ],
        scroll_down_title: "view all"
    }
  end

  def initialize_projects
    @projects = @popup_projects
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
        image_url: @project.item_top_banner_image.url,
    }

    @project_banner[:bg_image_url] = @project.item_top_banner_bg_image.url if @project.item_top_banner_bg_image.exists?
    #if respond_to?("init_#{@project.code_name}")
    #  send("init_#{@project.code_name}")
    #end

  end

  def set_navigation_links(project = @project)
    collection = @popup_projects
    # next_project = project.id
    # ids = @popup_projects.map(&:id)
    # current_index = ids.index(project.id)
    # prev_index = current_index - 1
    # next_index = current_index + 1
    # if prev_index < 0
    #   prev_index = ids.count - 1
    # end
    #
    # if next_index >= ids.count
    #   next_index = 0
    # end
    #
    # prev_id = ids[prev_index]
    # next_id = ids[next_index]
    #
    # prev_item = Project.find(prev_id)
    # next_item = Project.find(next_id)


    @prev, @next = [project.prev(collection), project.next(collection)].map{|item| {image: item.thumb.exists?(:thumb) ? item.thumb.url(:thumb) : item.avatar.url(:thumb), title: item.short_name, url: item.url } }
  end

  helper_method :template_exists?

  def render_partial(name, project_field = false, options = {} )

    if template_exists?("projects/#{@theme}/_#{name}")
      options = {partial: "projects/#{@theme}/#{name}"}.merge(options)
    elsif project_field == false || project_field.present?
      options = {partial: "#{name}"}.merge(options)
    else
      return ""
    end

    render_to_string(options)
  end

  helper_method :render_partial

  def init_shuvar_info
    @project_bottom_banner = {bg_image_url: "projects/shuvar_info/bottom_banner.jpg", asset_path: true}
  end
end
