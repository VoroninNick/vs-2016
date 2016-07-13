class CreateProjectsServices < ActiveRecord::Migration
  def change
    create_table :projects_services do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :service, index: true, foreign_key: true
    end
  end
end
