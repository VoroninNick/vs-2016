class AddDescriptiveNameToServices < ActiveRecord::Migration
  def change
    add_column :services, :descriptive_name, :string
    add_column :services, :long_description, :text

    add_column :service_translations, :descriptive_name, :string
    add_column :service_translations, :long_description, :text
  end
end
