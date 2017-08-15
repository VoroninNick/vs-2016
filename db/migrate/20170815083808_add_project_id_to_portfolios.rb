class AddProjectIdToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :project_id, :integer
  end
end
