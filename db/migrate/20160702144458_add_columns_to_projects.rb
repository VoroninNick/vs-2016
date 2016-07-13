class AddColumnsToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.date :released_on
    end

    [:projects, Project.translation_class.table_name].each do |table_name|
      change_table table_name do |t|
        t.string :site_url
        t.string :awards
        t.text :project_case
        t.text :logo_and_ci
        t.text :ux_and_strategy
        t.text :responsive_web_design
        t.text :technical_side_of_project
        t.text :seo_strategy
      end
    end

  end
end
