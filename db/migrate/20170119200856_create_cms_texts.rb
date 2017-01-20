class CreateCmsTexts < ActiveRecord::Migration
  def up
    Cms.create_tables(only: [:texts])
  end

  def down
    Cms.drop_tables(only: [:texts])
  end
end
