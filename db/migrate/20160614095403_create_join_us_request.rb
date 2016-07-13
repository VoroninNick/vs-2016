class CreateJoinUsRequest < ActiveRecord::Migration
  def change
    create_table :join_us_requests do |t|
      t.string :referer
      t.string :session_id
      t.string :locale
      t.string :name
      t.string :phone
      t.string :email
      t.string :desired_vacancy
      t.attachment :portfolio_attachment
      t.text :description

      t.timestamps null: false
    end
  end
end
