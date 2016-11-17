class CreateClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.boolean :published
      t.string :name
      t.text :short_description
      t.attachment :avatar
      t.string :url
      t.string :avatar_file_name_fallback
      t.string :avatar_alt
      t.boolean :no_follow_link

      t.timestamps null: false
    end

    Client.create_translation_table(:name, :short_description, :url, :avatar_alt)
    add_column :client_translations, :published, :boolean
  end

  def down
    Client.drop_translation_table!

    drop_table :clients
  end
end
