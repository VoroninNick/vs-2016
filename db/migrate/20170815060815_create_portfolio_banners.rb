class CreatePortfolioBanners < ActiveRecord::Migration
  def change
    create_table "portfolio_banners", force: true do |t|
      t.string   "name"
      t.text     "description"
      t.integer  "portfolio_id"
      t.datetime "created_at",                                null: false
      t.datetime "updated_at",                                null: false
      t.text     "title",                         limit: 255
      t.string   "background_file_name"
      t.string   "background_content_type"
      t.integer  "background_file_size"
      t.datetime "background_updated_at"
      t.string   "background_file_name_fallback"
      t.boolean  "published"
      t.string   "background_alt"
    end

    create_table "portfolio_banner_translations", force: true do |t|
      t.integer  "portfolio_banner_id", null: false
      t.string   "locale",              null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "title"
      t.text     "description"
      t.boolean  "published"
    end

    add_index "portfolio_banner_translations", ["locale"], name: "index_portfolio_banner_translations_on_locale"
    add_index "portfolio_banner_translations", ["portfolio_banner_id"], name: "index_portfolio_banner_translations_on_portfolio_banner_id"

  end
end
