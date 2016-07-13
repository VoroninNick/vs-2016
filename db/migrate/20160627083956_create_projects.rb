class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.boolean :published
      t.integer :sorting_position
      t.string :code_name
      t.attachment :avatar
      t.string :name
      t.string :url_fragment
      t.string :customer_name

      t.timestamps null: false
    end

    Project.initialize_globalize
    Project.create_translation_table!(name: :string, url_fragment: :string, customer_name: :string)
  end

  def down
    Project.drop_translation_table!

    drop_table :projects
  end
end
