class AddColumnsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
    end

    User.create_translation_table!(name: :string)
  end
end
