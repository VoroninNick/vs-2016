class AddBannersToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.attachment :item_top_banner_image
      t.attachment :vs_banner
      t.attachment :thumb
      t.attachment :item_bottom_banner_bg_image
      t.attachment :item_bottom_banner_image
    end

    [:projects, Project.translation_class.table_name].each do |table_name|
      change_table table_name do |t|
        t.string :short_name
        t.string :banner_title
        t.string :banner_title_sup
        t.text :short_description

      end
    end
  end
end
