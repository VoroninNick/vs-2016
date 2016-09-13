class AddJsonDataToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :json_data, :text
  end
end
