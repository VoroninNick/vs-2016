Rails.application.routes.draw do

  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  scope "test", controller: "test" do
    get "video_iframe"
  end


  root as: "root_without_locale", to: "application#root_without_locale"

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    post "hire-us-request", to: "forms#hire_us_request", as: :hire_us_request
    post "join-us-request", to: "forms#join_us_request", as: :join_us_request
    # scope :services, controller: "services" do
    #   root action: "index", as: :services
    #   get ":id", action: :show, as: "service"
    # end

    resources :services, only: [:index, :show]

    scope :articles, controller: :articles do
      root as: :articles, action: :index
      get "filters/:filters", as: :articles_filters, action: :index_with_filters
      get ":id", as: :article, action: :show
    end

    scope :projects, controller: "projects" do
      root action: :index, as: :projects
      get ":id", action: "show", as: :project_or_category
    end

    scope "blog", controller: "blog" do
      get "", action: "index", as: :blog
      get ":id", action: "show", as: "blog_article"
      get "/tags/:tags", action: "index", as: :article_tags
    end

    controller :pages do

      root action: "index"

      get "test", action: "test"


    end
  end

  scope "ajax", defaults: { ajax: true } do
    scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
      scope :projects, controller: "projects" do
        root action: :index, as: :ajax_projects
        get ":id", action: "show", as: :ajax_project_or_category
      end

      scope :articles, controller: :articles do
        get "filters/*filters", as: :ajax_articles_filters, action: :index_with_filters
      end
    end
  end






  locales = Cms.config.provided_locales

  Cms::Page.all.each do |p|
    if !p.class.try(:disabled?)
      controller_name = "pages"

      locales.each do |locale|
        route_name = "#{locale}_#{p.page_key}"
        url = p.url(locale)
        #url = p.default_url if url.blank?
        #url = "/#{url}" if url.start_with?("/")

        get url , controller: controller_name, action: p.page_key, as: route_name, defaults: {locale: locale, page_id: p.id}
      end
    end
  end

  match "*args", via: [:get, :post, :update, :delete, :create, :put], to: "application#render_not_found"
end
