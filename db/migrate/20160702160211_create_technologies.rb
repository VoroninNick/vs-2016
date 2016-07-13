class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name
      t.string :site_url
      t.attachment :icon
      t.integer :sorting_position

      t.timestamps null: false
    end
  end
end
