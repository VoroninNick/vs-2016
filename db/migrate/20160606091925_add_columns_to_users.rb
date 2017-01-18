class AddColumnsToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :name
    end

    User.create_translation_table!(name: :string)
  end

  def down
    User.drop_translation_table!

    remove_column :users, :name
  end
end
