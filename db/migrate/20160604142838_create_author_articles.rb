class CreateAuthorArticles < ActiveRecord::Migration
  def change
    create_table :author_articles do |t|
      #t.belongs_to :author, index: true, foreign_key: true
      t.integer :author_id
      t.belongs_to :article, index: true, foreign_key: true
    end
  end
end
