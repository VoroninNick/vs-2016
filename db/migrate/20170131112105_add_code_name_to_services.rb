class AddCodeNameToServices < ActiveRecord::Migration
  def change
    add_column :services, :code_name, :string
  end
end
