class AddPortfolioFilterNameToServices < ActiveRecord::Migration
  def change
    add_column :services, :portfolio_filter_name, :string
    add_column :service_translations, :portfolio_filter_name, :string
  end
end
