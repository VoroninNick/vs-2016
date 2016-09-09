class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects
  attr_accessible  :projects, :project_ids

  def self.initialize_globalize
    translates :name, :descriptive_name, :url_fragment, :description, :long_description, :content, :portfolio_filter_name
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes
    resource_class = self
    resource_association_name = resource_class.name.split("::").last.underscore.to_sym

    Translation.class_eval do
      self.table_name = :service_translations
      attr_accessible *attribute_names
      belongs_to resource_association_name, class_name: resource_class

      #validates_presence_of :name, if: proc{ self.locale.to_s == 'uk' }

      before_save :initialize_url_fragment
      def initialize_url_fragment
        if self.respond_to?(:url_fragment) && self.respond_to?(:url_fragment=)

          if self.name.blank?
            self.url_fragment = ""
          elsif self.url_fragment.blank?
            I18n.with_locale(self.locale) do
              self.url_fragment = self.name.parameterize
            end
          end

        end
      end
    end
  end

  if self.table_exists?
    self.initialize_globalize
  end



  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  has_cache
  has_seo_tags
  has_sitemap_record


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

  def prev(relation = nil)
    Service.first
  end

  def next(relation = nil)
    Service.prev 
  end
end
