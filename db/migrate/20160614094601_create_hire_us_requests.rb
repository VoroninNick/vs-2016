class CreateHireUsRequests < ActiveRecord::Migration
  def change
    create_table :hire_us_requests do |t|
      t.string :referer
      t.string :session_id
      t.string :locale
      t.string :name
      t.string :organization_name
      t.string :phone
      t.string :email
      t.string :budget_range
      t.text :description

      t.timestamps null: false
    end
  end
end
