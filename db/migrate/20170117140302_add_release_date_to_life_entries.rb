class AddReleaseDateToLifeEntries < ActiveRecord::Migration
  def change
    add_column :life_entries, :release_date, :date
  end
end
