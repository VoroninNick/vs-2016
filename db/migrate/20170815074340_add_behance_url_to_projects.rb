class AddBehanceUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :behance_url, :string
  end
end
