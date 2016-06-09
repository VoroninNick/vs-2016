class ArticlesController < ApplicationController
  before_action :initialize_article, only: :show

  def index
    @articles = Article.published
    @tags = Cms::Tag.all
    @authors = User.authors



    @page_banner = {
        bg_image: 'banners/services.jpg',
        title: "Publications",
        numbers: [
          {number: @articles.count, number_description: "articles"},
          {number: @tags.count, number_description: "tags"},
          {number: @authors.count, number_description: "authors"}
        ],
        scroll_down_title: "view all"
    }
  end

  def show
    if @article
      @page_banner_template = "article_banner"
      @page_banner = {
          bg_image: 'banners/services.jpg',
          title: @article.name,
          numbers: [
              {number: "08", number_description: "cases"}
          ],
          scroll_down_title: "read more"
      }
    end
  end

  private
  def initialize_article
    @article = Article.published.joins(:translations).where(article_translations: { url_fragment: params[:id], locale: params[:locale] } ).first
    if @article.nil?
      render_not_found
    end
  end
end