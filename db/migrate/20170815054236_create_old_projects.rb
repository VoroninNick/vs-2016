class CreateOldProjects < ActiveRecord::Migration
  def change
    create_table "portfolios", force: true do |t|
      t.string   "name"
      t.datetime "created_at",                      null: false
      t.datetime "updated_at",                      null: false
      t.integer  "portfolio_category_id"
      t.string   "url_fragment"
      t.integer  "portfolio_banner_id"
      t.integer  "portfolio_technology_id"
      t.integer  "developer_id"
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.text     "result"
      t.text     "result_eng"
      t.text     "process"
      t.text     "process_eng"
      t.text     "live"
      t.text     "live_eng"
      t.date     "release"
      t.boolean  "published"
      t.text     "description"
      t.text     "thanks_to"
      t.text     "task"
      t.string   "thanks_image_file_name"
      t.string   "thanks_image_content_type"
      t.integer  "thanks_image_file_size"
      t.string   "thanks_image_updated_at"
      t.string   "title"
      t.string   "avatar_file_name_fallback"
      t.string   "avatar_alt"
      t.string   "thanks_image_alt"
      t.string   "thanks_image_file_name_fallback"
    end

    create_table "portfolio_translations", force: true do |t|
      t.integer  "portfolio_id", null: false
      t.string   "locale",       null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
      t.string   "url_fragment"
      t.text     "task"
      t.text     "result"
      t.text     "process"
      t.text     "live"
      t.text     "description"
      t.text     "thanks_to"
      t.string   "avatar_alt"
      t.boolean  "published"
    end

    add_index "portfolio_translations", ["locale"], name: "index_portfolio_translations_on_locale"
    add_index "portfolio_translations", ["portfolio_id"], name: "index_portfolio_translations_on_portfolio_id"
  end
end
