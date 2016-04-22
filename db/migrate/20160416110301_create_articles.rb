class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.boolean :published
      t.string :name
      t.string :url_fragment
      t.text :content
      t.date :release_date
      t.attachment :avatar
      t.integer :author_id

      t.timestamps null: false
    end

    Article.initialize_globalize
    Article.create_translation_table!(name: :string, url_fragment: :string, content: :text)
  end

  def down
    Article.drop_translation_table!

    drop_table :articles
  end
end
