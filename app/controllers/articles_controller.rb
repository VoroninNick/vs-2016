class ArticlesController < ApplicationController
  before_action :initialize_articles
  before_action :initialize_article, only: :show

  def index
    @tags = Cms::Tag.all.joins(:articles).where(articles: { published: "t" })
    @authors = User.authors



    @page_banner = {
        bg_image: 'banners/inner-page-main-banners-v1-publications.jpg',
        title: "Publications",
        numbers: [
          {number: @articles.count, number_description: "articles"},
          {number: @tags.count, number_description: "tags"},
          {number: @authors.count, number_description: "authors"}
        ],
        scroll_down_title: "view all"
    }


  end

  def index_with_filters

    filters = Hash[params[:filters].split("___").map{|param| k,v = param.split("__"); [k.to_sym, v] }]

    tags = filters[:tags].present? ? filters[:tags].split(",") : []
    authors = filters[:authors].present? ? filters[:authors].split(",") : []
    @filtered_articles = @articles
    if tags.present?
      @filtered_articles = @filtered_articles.joins(:tags).where(cms_tags: { id: tags })
    end

    if authors.present?
      @filtered_articles = @filtered_articles.joins(:authors).where(users: { id: authors })
    end

    render template: "articles/_articles.html", locals: {articles: @filtered_articles}, layout: false
  end

  def show
    if @article
      @page_banner_template = "article_banner"
      @page_banner = {
          bg_image: 'banners/inner-page-main-banners-v1-publications.jpg',
          title: @article.name,
          numbers: [
              {number: "08", number_description: "cases"}
          ],
          scroll_down_title: "read more"
      }
    end
  end

  private
  def initialize_articles
    @articles = Article.published
    params[:tags]
  end

  def initialize_article
    @article = @articles.joins(:translations).where(article_translations: { url_fragment: params[:id], locale: params[:locale] } ).first
    if @article.nil?
      render_not_found
    end
  end
end