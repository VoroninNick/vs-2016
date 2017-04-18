class AddFeaturedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :featured, :boolean
    add_column :projects, :featured_position, :integer
  end
end
