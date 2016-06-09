class CreateBlogArticles < ActiveRecord::Migration
  def up
    BlogArticle.create_article_table
  end

  def down
    BlogArticle.drop_article_table
  end
end
