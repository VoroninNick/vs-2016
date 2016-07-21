class AddHomeBannerImageToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.attachment :home_banner_image
    end

  end
end
