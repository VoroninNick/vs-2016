class CreateMembers < ActiveRecord::Migration
  def up
    create_table :members do |t|
      t.string :name
      t.string :role
      t.string :few_words_about
      t.attachment :image

      t.timestamps null: false
    end
    Member.initialize_globalize
    Member.create_translation_table!(name: :string, role: :string, few_words_about: :string)
  end

  def down
    Member.drop_translation_table!

    drop_table :members
  end
end
