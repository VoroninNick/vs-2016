class AddBackgroundImagesToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.attachment :logo_and_ci_bg_image
      t.attachment :ux_bg_image
      t.attachment :rwd_bg_image
      t.attachment :technical_side_of_project_bg_image
    end
  end
end
