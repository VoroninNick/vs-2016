class AddShowSwingOnHomeBanner < ActiveRecord::Migration
  def change
    add_column :projects, :show_swing_on_home_banner, :boolean
  end
end
