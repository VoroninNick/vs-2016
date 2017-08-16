class AddPublishedAndSortingPosionToMembers < ActiveRecord::Migration
  def change
    add_column :members, :published, :boolean
    add_column :members, :sorting_position, :integer
  end
end
