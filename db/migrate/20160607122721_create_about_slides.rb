class CreateAboutSlides < ActiveRecord::Migration
  def change
    create_table :about_slides do |t|
      t.integer :sorting_position
      t.boolean :published
      t.attachment :image

      t.timestamps null: false
    end
  end
end
