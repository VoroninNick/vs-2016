class PublishMembers < ActiveRecord::Migration
  def change
    Member.update_all(published: 't')
  end
end
