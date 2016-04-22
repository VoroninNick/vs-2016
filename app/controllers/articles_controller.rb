class ArticlesController < ApplicationController
  def index
    @articles = Article.published
    @tags = Cms::Tag.all
    @authors = User.all



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

  end
end