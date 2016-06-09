class BlogController < ApplicationController
  caches_page :index, :show

  def index
    @available_tags = []
    @available_authors = []

    set_page_metadata("blog")

    add_home_breadcrumb
    add_breadcrumb("blog")

    per_page = 18
    page = params[:page].try(&:to_i) || 1

    all_articles = BlogArticle.published.sort_by_popularity_desc
    pages_count = params[:pages_count].try(&:to_i) || 1

    if pages_count == 1
      @articles = all_articles.limit(per_page)
    else
      @articles = all_articles.offset(per_page * (page - 1) ).limit(pages_count * per_page)
    end

    @tags = BlogArticle.published.tag_counts_on(:tags)

    #@author_names = BlogArticle.published.pluck(:author_name).uniq.select(&:present?)
    #@author_names = User.joins(:articles).where(blog_articles: { published: 't' } ).pluck(:name)
    @authors = User.valid_authors.authors_with_articles.pluck_to_hash(:id, :name)

    @total_articles = BlogArticle.published.count
    @total_pages_count = (@total_articles.to_f / per_page).ceil


    if params.has_key?(:ajax)
      res = {}
      res[:html] = render_to_string( template: "application/_articles_collection" , layout: false, locals: { items: @articles })
      render json: res
    end
  end

  def show
    @article = BlogArticle.published.where(url_fragment: params[:id]).first
    if @article
      @article.update_attributes(views: (@article.views || 0) + 1 )

      set_page_metadata(@article)

      @og_image = @article.avatar.url

      add_home_breadcrumb
      add_breadcrumb("blog")
      add_breadcrumb(@article.name, false)

      @related_articles = @article.related_articles

      #init_articles_navigation
    else
      render_not_found
    end
  end
end