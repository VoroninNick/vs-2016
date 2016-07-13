class CreateProjectsTechnologies < ActiveRecord::Migration
  def change
    create_table :projects_technologies do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :technology, index: true, foreign_key: true
    end
  end
end
