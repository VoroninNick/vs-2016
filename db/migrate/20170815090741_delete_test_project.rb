class DeleteTestProject < ActiveRecord::Migration
  def up
    Portfolio.find(34).delete
    Project.find(104).delete
  end
end
