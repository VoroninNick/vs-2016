class CreateLifeEntries < ActiveRecord::Migration
  def up
    create_table :life_entries do |t|
      t.attachment :image
      t.text :description
      t.boolean :published
      t.integer :sorting_position

      t.timestamps null: false
    end

    LifeEntry.create_translation_table(:description)
  end

  def down
    LifeEntry.drop_translation_table!

    drop_table :life_entries
  end
end
