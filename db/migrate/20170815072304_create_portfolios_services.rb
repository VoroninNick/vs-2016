class CreatePortfoliosServices < ActiveRecord::Migration
  def change
    create_join_table :portfolios, :services
  end
end
