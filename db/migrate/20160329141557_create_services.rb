class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.boolean :published
      t.integer :sorting_position
      t.string :name
      t.string :url_fragment
      t.text :description
      t.text :content
      t.attachment :icon
      t.attachment :home_bg
      t.attachment :list_image




      t.timestamps null: false
    end

    Service.initialize_globalize
    Service.create_translation_table!(name: :string, url_fragment: :string, description: :text, content: :text)
  end

  def down
    Service.drop_translation_table!

    drop_table :services
  end
end
