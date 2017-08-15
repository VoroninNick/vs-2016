class DeleteTestProject < ActiveRecord::Migration
  def up
    Portfolio.find(34).delete
    Project.find(104).delete rescue true
  end
end
