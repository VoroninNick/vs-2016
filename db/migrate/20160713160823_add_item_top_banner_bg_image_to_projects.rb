class AddItemTopBannerBgImageToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.attachment :item_top_banner_bg_image
    end
  end
end
