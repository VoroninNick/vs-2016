class AddPostLinkToLifeEntries < ActiveRecord::Migration
  def change
    add_column :life_entries, :post_link, :string
  end
end
