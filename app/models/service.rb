class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects
  attr_accessible  :projects, :project_ids

  globalize :name, :descriptive_name, :url_fragment, :description, :long_description, :content, :portfolio_filter_name

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  has_cache do
    pages :about_us, :articles, :contacts, :home, :projects, :services, :studio_life, Project.published, Article.published, Service.published

    Cms.config.provided_locales.each do |locale|
      pages "/ajax/#{locale}/projects/*"
    end
  end
  has_seo_tags
  has_sitemap_record
  has_navigation


  # attachents

  has_attached_file :icon
  has_attached_file :home_bg, styles: { xxl: "840x420#" }
  has_attached_file :list_image, styles: { xxl: "1024x850#", home_xxl: "840x420#", thumb: "100x100#" }

  [:icon, :home_bg, :list_image].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
    do_not_validate_attachment_file_type attachment_name
  end


  def descriptive_name(locale = I18n.locale)
    t = self.translations_by_locale[locale]

    v = t.descriptive_name
    if v.blank?
      v = t.name
    end

    return v
  end

  def long_description(locale = I18n.locale)
    t = self.translations_by_locale[locale]

    v = t.long_description
    if v.blank?
      v = t.description
    end

    return v
  end

  def url(locale = I18n.locale)
    v = self.translations_by_locale[locale].url_fragment
    if !v.start_with?("/")
      v = "/#{v}"
    end

    "/#{locale}/services#{v}"
  end

  # def prev(relation = nil)
  #   Service.first
  # end
  #
  # def next(relation = nil)
  #   Service.prev
  # end
end
