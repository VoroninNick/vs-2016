class UnpublishMissedBehanceProjects < ActiveRecord::Migration
  def up
    Project.where(id: [74, 67]).update_all(published: 'f')
  end
end
