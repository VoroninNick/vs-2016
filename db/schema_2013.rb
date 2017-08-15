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

ActiveRecord::Schema.define(version: 20140929120459) do

  create_table "article_translations", force: true do |t|
    t.integer  "article_id",        null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "short_description"
    t.text     "content"
    t.string   "avatar_alt"
    t.boolean  "published"
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id"
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale"

  create_table "articles", force: true do |t|
    t.boolean  "published"
    t.string   "name"
    t.text     "short_description",         limit: 255
    t.text     "content"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.date     "original_published"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "slug"
    t.datetime "release_date"
    t.string   "author"
    t.string   "title"
    t.string   "avatar_file_name_fallback"
    t.string   "avatar_alt"
  end

  create_table "banners", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "published"
  end

  create_table "ckeditor_assets", force: true do |t|
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

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "code_pages", force: true do |t|
    t.text     "code"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_article_translations", force: true do |t|
    t.integer  "custom_article_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.text     "short_description"
    t.text     "full_description"
    t.string   "avatar_alt"
    t.boolean  "published"
  end

  add_index "custom_article_translations", ["custom_article_id"], name: "index_custom_article_translations_on_custom_article_id"
  add_index "custom_article_translations", ["locale"], name: "index_custom_article_translations_on_locale"

  create_table "custom_articles", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "short_description"
    t.text     "full_description"
    t.boolean  "published"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "avatar_file_name_fallback"
    t.string   "avatar_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "developer_roles", force: true do |t|
    t.string   "name"
    t.integer  "developer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "developer_roles", ["developer_id"], name: "index_developer_roles_on_developer_id"

  create_table "developers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "developer_role_id"
    t.string   "facebook_profile"
    t.string   "vkontakte_profile"
    t.string   "twitter_profile"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "portfolio_id"
    t.string   "avatar_file_name_fallback"
    t.string   "avatar_alt"
  end

  add_index "developers", ["developer_role_id"], name: "index_developers_on_developer_role_id"

  create_table "dictionaries", force: true do |t|
    t.string   "name"
    t.string   "code_name"
    t.text     "info_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dictionary_key_translations", force: true do |t|
    t.integer  "dictionary_key_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "value"
  end

  add_index "dictionary_key_translations", ["dictionary_key_id"], name: "index_dictionary_key_translations_on_dictionary_key_id"
  add_index "dictionary_key_translations", ["locale"], name: "index_dictionary_key_translations_on_locale"

  create_table "dictionary_keys", force: true do |t|
    t.text     "key"
    t.text     "value"
    t.text     "info_description"
    t.integer  "dictionary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_configs", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms_join_us", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "portfolio_file_name"
    t.string   "portfolio_content_type"
    t.integer  "portfolio_file_size"
    t.datetime "portfolio_updated_at"
    t.string   "role"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "forms_orders", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "organization_name"
    t.string   "email"
    t.string   "money"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "home_banner_slide_layers", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.text     "style"
    t.text     "options"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "home_banner_slide_id"
  end

  create_table "home_banner_slides", force: true do |t|
    t.string   "name"
    t.boolean  "published"
    t.integer  "order_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "page_contact_page", force: true do |t|
    t.text    "content"
    t.boolean "published"
  end

  create_table "page_contact_page_translations", force: true do |t|
    t.integer  "page_contact_page_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.boolean  "published"
  end

  add_index "page_contact_page_translations", ["locale"], name: "index_page_contact_page_translations_on_locale"
  add_index "page_contact_page_translations", ["page_contact_page_id"], name: "index_page_contact_page_translations_on_page_contact_page_id"

  create_table "page_join_us_page", force: true do |t|
    t.text    "content"
    t.boolean "published"
  end

  create_table "page_join_us_page_translations", force: true do |t|
    t.integer  "page_join_us_page_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.boolean  "published"
  end

  add_index "page_join_us_page_translations", ["locale"], name: "index_page_join_us_page_translations_on_locale"
  add_index "page_join_us_page_translations", ["page_join_us_page_id"], name: "index_page_join_us_page_translations_on_page_join_us_page_id"

  create_table "page_metadata", force: true do |t|
    t.string   "path"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.integer  "metataggable_id"
    t.string   "metataggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_order_page", force: true do |t|
    t.text    "content"
    t.boolean "published"
  end

  create_table "page_order_page_translations", force: true do |t|
    t.integer  "page_order_page_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.boolean  "published"
  end

  add_index "page_order_page_translations", ["locale"], name: "index_page_order_page_translations_on_locale"
  add_index "page_order_page_translations", ["page_order_page_id"], name: "index_page_order_page_translations_on_page_order_page_id"

  create_table "pages_about_page_translations", force: true do |t|
    t.integer  "pages_about_page_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.text     "clients_intro"
    t.text     "team_text"
    t.boolean  "published"
  end

  add_index "pages_about_page_translations", ["locale"], name: "index_pages_about_page_translations_on_locale"
  add_index "pages_about_page_translations", ["pages_about_page_id"], name: "index_pages_about_page_translations_on_pages_about_page_id"

  create_table "pages_about_pages", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "clients_intro"
    t.text     "team_text"
    t.boolean  "published"
  end

  create_table "pages_articles_list_pages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_home_page_translations", force: true do |t|
    t.integer  "pages_home_page_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "greetings"
    t.boolean  "published"
  end

  add_index "pages_home_page_translations", ["locale"], name: "index_pages_home_page_translations_on_locale"
  add_index "pages_home_page_translations", ["pages_home_page_id"], name: "index_pages_home_page_translations_on_pages_home_page_id"

  create_table "pages_home_pages", force: true do |t|
    t.text     "greetings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  create_table "pages_portfolio_corporate_identity_list_pages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_portfolio_list_page_translations", force: true do |t|
    t.integer  "pages_portfolio_list_page_id", null: false
    t.string   "locale",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro_text"
    t.boolean  "published"
  end

  add_index "pages_portfolio_list_page_translations", ["locale"], name: "index_pages_portfolio_list_page_translations_on_locale"
  add_index "pages_portfolio_list_page_translations", ["pages_portfolio_list_page_id"], name: "index_3660313a9c6172e46b6660b3682df86fafc7f6a2"

  create_table "pages_portfolio_list_pages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro_text"
    t.boolean  "published"
  end

  create_table "pages_portfolio_polygraphy_list_pages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_portfolio_web_list_pages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_services_page_translations", force: true do |t|
    t.integer  "pages_services_page_id", null: false
    t.string   "locale",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro_text"
    t.text     "footer_text"
    t.boolean  "published"
  end

  add_index "pages_services_page_translations", ["locale"], name: "index_pages_services_page_translations_on_locale"
  add_index "pages_services_page_translations", ["pages_services_page_id"], name: "index_3409342faf0a6f043c19ff1aacf3e31f3fdc8315"

  create_table "pages_services_pages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro_text"
    t.text     "footer_text"
    t.boolean  "published"
  end

  create_table "portfolio_banner_layers", force: true do |t|
    t.string   "name"
    t.string   "style"
    t.string   "animation_options"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
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

  create_table "portfolio_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "slug"
    t.integer  "portfolio_id"
    t.string   "name_eng"
    t.string   "title"
    t.boolean  "published"
    t.text     "full_description"
    t.text     "short_description"
  end

  add_index "portfolio_categories", ["slug"], name: "index_portfolio_categories_on_slug"

  create_table "portfolio_category_translations", force: true do |t|
    t.integer  "portfolio_category_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.boolean  "published"
    t.text     "full_description"
    t.text     "short_description"
  end

  add_index "portfolio_category_translations", ["locale"], name: "index_portfolio_category_translations_on_locale"
  add_index "portfolio_category_translations", ["portfolio_category_id"], name: "index_portfolio_category_translations_on_portfolio_category_id"

  create_table "portfolio_tag_scopes", force: true do |t|
    t.integer  "scope_taggable_id"
    t.string   "scope_taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolio_technologies", force: true do |t|
    t.string   "name"
    t.string   "official_link"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "portfolio_id"
    t.string   "avatar_file_name_fallback"
    t.string   "avatar_alt"
  end

  create_table "portfolio_translations", force: true do |t|
    t.integer  "portfolio_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
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

  create_table "portfolios", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "portfolio_category_id"
    t.string   "slug"
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

  add_index "portfolios", ["slug"], name: "index_portfolios_on_slug"

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "route_translations", force: true do |t|
    t.integer  "route_id",        null: false
    t.string   "locale",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "route_string"
    t.string   "redirect_to_url"
  end

  add_index "route_translations", ["locale"], name: "index_route_translations_on_locale"
  add_index "route_translations", ["route_id"], name: "index_route_translations_on_route_id"

  create_table "routes", force: true do |t|
    t.string   "name"
    t.string   "route_string"
    t.string   "route_name"
    t.string   "controller_action"
    t.string   "redirect_to_url"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "routes", ["position"], name: "index_routes_on_position"

  create_table "service_translations", force: true do |t|
    t.integer  "service_id",        null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "short_description"
    t.text     "full_description"
    t.string   "avatar_alt"
    t.string   "slug"
    t.string   "name"
    t.boolean  "published"
  end

  add_index "service_translations", ["locale"], name: "index_service_translations_on_locale"
  add_index "service_translations", ["service_id"], name: "index_service_translations_on_service_id"

  create_table "services", force: true do |t|
    t.boolean  "published"
    t.string   "name"
    t.text     "short_description"
    t.text     "full_description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "sort_id"
    t.integer  "services_page_id"
    t.string   "avatar_alt"
    t.string   "slug"
    t.string   "avatar_file_name_fallback"
  end

  create_table "sitemap_element_translations", force: true do |t|
    t.integer  "sitemap_element_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "path"
    t.string   "url"
    t.string   "changefreq"
    t.float    "priority"
    t.datetime "lastmod"
    t.boolean  "display_on_sitemap"
  end

  add_index "sitemap_element_translations", ["locale"], name: "index_sitemap_element_translations_on_locale"
  add_index "sitemap_element_translations", ["sitemap_element_id"], name: "index_sitemap_element_translations_on_sitemap_element_id"

  create_table "sitemap_elements", force: true do |t|
    t.string   "path"
    t.string   "url"
    t.string   "changefreq"
    t.float    "priority"
    t.datetime "lastmod"
    t.integer  "sitemappable_id"
    t.string   "sitemappable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "display_on_sitemap"
    t.integer  "static_page_data_id"
  end

  create_table "static_page_data", force: true do |t|
    t.string   "url"
    t.string   "body_title"
    t.string   "head_title"
    t.text     "meta_keywords"
    t.text     "meta_description"
    t.integer  "has_static_page_data_id"
    t.string   "has_static_page_data_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_page_datum_translations", force: true do |t|
    t.integer  "static_page_datum_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "head_title"
    t.text     "meta_keywords"
    t.text     "meta_description"
  end

  add_index "static_page_datum_translations", ["locale"], name: "index_static_page_datum_translations_on_locale"
  add_index "static_page_datum_translations", ["static_page_datum_id"], name: "index_static_page_datum_translations_on_static_page_datum_id"

  create_table "tag_translations", force: true do |t|
    t.string  "locale"
    t.integer "tag_id"
    t.string  "name"
  end

  add_index "tag_translations", ["locale"], name: "index_tag_translations_on_locale"
  add_index "tag_translations", ["tag_id"], name: "index_tag_translations_on_tag_id"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "trust_companies", force: true do |t|
    t.boolean  "published"
    t.string   "name"
    t.string   "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "url"
    t.string   "avatar_file_name_fallback"
    t.string   "avatar_alt"
    t.boolean  "no_follow_link"
  end

  create_table "trust_company_translations", force: true do |t|
    t.integer  "trust_company_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.string   "avatar_alt"
    t.boolean  "published"
  end

  add_index "trust_company_translations", ["locale"], name: "index_trust_company_translations_on_locale"
  add_index "trust_company_translations", ["trust_company_id"], name: "index_trust_company_translations_on_trust_company_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.string   "locale"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
