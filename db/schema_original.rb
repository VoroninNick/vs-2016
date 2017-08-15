# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170418104555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "about_slides", force: :cascade do |t|
    t.integer  "sorting_position"
    t.boolean  "published"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "article_translations", force: :cascade do |t|
    t.integer  "article_id",   null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.string   "url_fragment"
    t.text     "content"
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id", using: :btree
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale", using: :btree

  create_table "articles", force: :cascade do |t|
    t.boolean  "published"
    t.string   "name"
    t.string   "url_fragment"
    t.text     "content"
    t.date     "release_date"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "author_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "asset_translations", force: :cascade do |t|
    t.integer  "asset_id",   null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "data_alt"
  end

  add_index "asset_translations", ["asset_id"], name: "index_asset_translations_on_asset_id", using: :btree
  add_index "asset_translations", ["locale"], name: "index_asset_translations_on_locale", using: :btree

  create_table "assets", force: :cascade do |t|
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.string   "assetable_field_name"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.string   "data_alt"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "author_articles", force: :cascade do |t|
    t.integer "author_id"
    t.integer "article_id"
  end

  create_table "blog_articles", force: :cascade do |t|
    t.boolean  "published"
    t.string   "name"
    t.text     "short_description"
    t.text     "content"
    t.string   "url_fragment"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "author_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "client_translations", force: :cascade do |t|
    t.integer  "client_id",         null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
    t.text     "short_description"
    t.string   "url"
    t.string   "avatar_alt"
    t.boolean  "published"
  end

  add_index "client_translations", ["client_id"], name: "index_client_translations_on_client_id", using: :btree
  add_index "client_translations", ["locale"], name: "index_client_translations_on_locale", using: :btree

  create_table "clients", force: :cascade do |t|
    t.boolean  "published"
    t.string   "name"
    t.text     "short_description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "url"
    t.string   "avatar_file_name_fallback"
    t.string   "avatar_alt"
    t.boolean  "no_follow_link"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "cms_tag_translations", force: :cascade do |t|
    t.integer  "cms_tag_id",   null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.string   "url_fragment"
  end

  add_index "cms_tag_translations", ["cms_tag_id"], name: "index_cms_tag_translations_on_cms_tag_id", using: :btree
  add_index "cms_tag_translations", ["locale"], name: "index_cms_tag_translations_on_locale", using: :btree

  create_table "cms_taggings", force: :cascade do |t|
    t.integer "taggable_id"
    t.string  "taggable_type"
    t.string  "taggable_field_name"
    t.integer "tag_id"
  end

  create_table "cms_tags", force: :cascade do |t|
    t.integer "tagging_id"
    t.string  "name"
    t.string  "url_fragment"
  end

  create_table "form_configs", force: :cascade do |t|
    t.string   "type"
    t.text     "email_receivers"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "hire_us_requests", force: :cascade do |t|
    t.string   "referer"
    t.string   "session_id"
    t.string   "locale"
    t.string   "name"
    t.string   "organization_name"
    t.string   "phone"
    t.string   "email"
    t.string   "budget_range"
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "join_us_requests", force: :cascade do |t|
    t.string   "referer"
    t.string   "session_id"
    t.string   "locale"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "desired_vacancy"
    t.string   "portfolio_attachment_file_name"
    t.string   "portfolio_attachment_content_type"
    t.integer  "portfolio_attachment_file_size"
    t.datetime "portfolio_attachment_updated_at"
    t.text     "description"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "life_entries", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.boolean  "published"
    t.integer  "sorting_position"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "post_link"
    t.date     "release_date"
  end

  create_table "life_entry_translations", force: :cascade do |t|
    t.integer  "life_entry_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "description"
  end

  add_index "life_entry_translations", ["life_entry_id"], name: "index_life_entry_translations_on_life_entry_id", using: :btree
  add_index "life_entry_translations", ["locale"], name: "index_life_entry_translations_on_locale", using: :btree

  create_table "member_translations", force: :cascade do |t|
    t.integer  "member_id",       null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "role"
    t.string   "few_words_about"
  end

  add_index "member_translations", ["locale"], name: "index_member_translations_on_locale", using: :btree
  add_index "member_translations", ["member_id"], name: "index_member_translations_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
    t.string   "few_words_about"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "page_translations", force: :cascade do |t|
    t.integer  "page_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
    t.text     "content"
    t.string   "name"
  end

  add_index "page_translations", ["locale"], name: "index_page_translations_on_locale", using: :btree
  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.text     "content"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_translations", force: :cascade do |t|
    t.integer  "project_id",                null: false
    t.string   "locale",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.string   "url_fragment"
    t.string   "customer_name"
    t.string   "site_url"
    t.string   "awards"
    t.text     "project_case"
    t.text     "logo_and_ci"
    t.text     "ux_and_strategy"
    t.text     "responsive_web_design"
    t.text     "technical_side_of_project"
    t.text     "seo_strategy"
    t.string   "short_name"
    t.string   "banner_title"
    t.string   "banner_title_sup"
    t.text     "short_description"
  end

  add_index "project_translations", ["locale"], name: "index_project_translations_on_locale", using: :btree
  add_index "project_translations", ["project_id"], name: "index_project_translations_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.boolean  "published"
    t.integer  "sorting_position"
    t.string   "code_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.string   "url_fragment"
    t.string   "customer_name"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.date     "released_on"
    t.string   "site_url"
    t.string   "awards"
    t.text     "project_case"
    t.text     "logo_and_ci"
    t.text     "ux_and_strategy"
    t.text     "responsive_web_design"
    t.text     "technical_side_of_project"
    t.text     "seo_strategy"
    t.string   "item_top_banner_image_file_name"
    t.string   "item_top_banner_image_content_type"
    t.integer  "item_top_banner_image_file_size"
    t.datetime "item_top_banner_image_updated_at"
    t.string   "vs_banner_file_name"
    t.string   "vs_banner_content_type"
    t.integer  "vs_banner_file_size"
    t.datetime "vs_banner_updated_at"
    t.string   "thumb_file_name"
    t.string   "thumb_content_type"
    t.integer  "thumb_file_size"
    t.datetime "thumb_updated_at"
    t.string   "item_bottom_banner_bg_image_file_name"
    t.string   "item_bottom_banner_bg_image_content_type"
    t.integer  "item_bottom_banner_bg_image_file_size"
    t.datetime "item_bottom_banner_bg_image_updated_at"
    t.string   "item_bottom_banner_image_file_name"
    t.string   "item_bottom_banner_image_content_type"
    t.integer  "item_bottom_banner_image_file_size"
    t.datetime "item_bottom_banner_image_updated_at"
    t.string   "short_name"
    t.string   "banner_title"
    t.string   "banner_title_sup"
    t.text     "short_description"
    t.string   "item_top_banner_bg_image_file_name"
    t.string   "item_top_banner_bg_image_content_type"
    t.integer  "item_top_banner_bg_image_file_size"
    t.datetime "item_top_banner_bg_image_updated_at"
    t.string   "logo_and_ci_bg_image_file_name"
    t.string   "logo_and_ci_bg_image_content_type"
    t.integer  "logo_and_ci_bg_image_file_size"
    t.datetime "logo_and_ci_bg_image_updated_at"
    t.string   "ux_bg_image_file_name"
    t.string   "ux_bg_image_content_type"
    t.integer  "ux_bg_image_file_size"
    t.datetime "ux_bg_image_updated_at"
    t.string   "rwd_bg_image_file_name"
    t.string   "rwd_bg_image_content_type"
    t.integer  "rwd_bg_image_file_size"
    t.datetime "rwd_bg_image_updated_at"
    t.string   "technical_side_of_project_bg_image_file_name"
    t.string   "technical_side_of_project_bg_image_content_type"
    t.integer  "technical_side_of_project_bg_image_file_size"
    t.datetime "technical_side_of_project_bg_image_updated_at"
    t.string   "home_banner_image_file_name"
    t.string   "home_banner_image_content_type"
    t.integer  "home_banner_image_file_size"
    t.datetime "home_banner_image_updated_at"
    t.boolean  "show_swing_on_home_banner"
    t.text     "json_data"
    t.boolean  "featured"
    t.integer  "featured_position"
  end

  create_table "projects_services", force: :cascade do |t|
    t.integer "project_id"
    t.integer "service_id"
  end

  create_table "projects_technologies", force: :cascade do |t|
    t.integer "project_id"
    t.integer "technology_id"
  end

  create_table "seo_tag_translations", force: :cascade do |t|
    t.integer  "seo_tag_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "keywords"
    t.text     "description"
  end

  add_index "seo_tag_translations", ["locale"], name: "index_seo_tag_translations_on_locale", using: :btree
  add_index "seo_tag_translations", ["seo_tag_id"], name: "index_seo_tag_translations_on_seo_tag_id", using: :btree

  create_table "seo_tags", force: :cascade do |t|
    t.string  "page_type"
    t.integer "page_id"
    t.string  "title"
    t.text    "keywords"
    t.text    "description"
  end

  create_table "service_translations", force: :cascade do |t|
    t.integer  "service_id",            null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name"
    t.string   "url_fragment"
    t.text     "description"
    t.text     "content"
    t.string   "descriptive_name"
    t.text     "long_description"
    t.string   "portfolio_filter_name"
  end

  add_index "service_translations", ["locale"], name: "index_service_translations_on_locale", using: :btree
  add_index "service_translations", ["service_id"], name: "index_service_translations_on_service_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.boolean  "published"
    t.integer  "sorting_position"
    t.string   "name"
    t.string   "url_fragment"
    t.text     "description"
    t.text     "content"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "home_bg_file_name"
    t.string   "home_bg_content_type"
    t.integer  "home_bg_file_size"
    t.datetime "home_bg_updated_at"
    t.string   "list_image_file_name"
    t.string   "list_image_content_type"
    t.integer  "list_image_file_size"
    t.datetime "list_image_updated_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "descriptive_name"
    t.text     "long_description"
    t.string   "portfolio_filter_name"
    t.string   "code_name"
  end

  create_table "sitemap_elements", force: :cascade do |t|
    t.string   "page_type"
    t.integer  "page_id"
    t.boolean  "display_on_sitemap"
    t.string   "changefreq"
    t.float    "priority"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.string   "site_url"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.integer  "sorting_position"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "text_translations", force: :cascade do |t|
    t.integer  "text_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "content"
  end

  add_index "text_translations", ["locale"], name: "index_text_translations_on_locale", using: :btree
  add_index "text_translations", ["text_id"], name: "index_text_translations_on_text_id", using: :btree

  create_table "texts", force: :cascade do |t|
    t.string   "key",        null: false
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "texts", ["key"], name: "index_texts_on_key", unique: true, using: :btree

  create_table "user_translations", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "user_translations", ["locale"], name: "index_user_translations_on_locale", using: :btree
  add_index "user_translations", ["user_id"], name: "index_user_translations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
