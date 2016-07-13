class Project < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :services
  attr_accessible :services, :service_ids

  has_and_belongs_to_many :technologies
  attr_accessible :technologies, :technology_ids

  def self.initialize_globalize
    translates :name, :customer_name, :url_fragment, :site_url, :awards, :project_case, :logo_and_ci, :ux_and_strategy, :responsive_web_design, :technical_side_of_project, :seo_strategy
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes
    resource_class = self
    resource_association_name = resource_class.name.split("::").last.underscore.to_sym

    Translation.class_eval do
      self.table_name = :project_translations
      attr_accessible *attribute_names
      belongs_to resource_association_name, class_name: resource_class

      #validates_presence_of :name, if: proc{ self.locale.to_s == 'uk' }

        before_save :initialize_url_fragment
      def initialize_url_fragment
        if self.respond_to?(:url_fragment) && self.respond_to?(:url_fragment=)

          if self.name.blank?
            self.url_fragment = ""
          elsif self.url_fragment.blank?
            with_locale = self.locale
            with_locale = :ru if self.locale.to_sym == :uk
            I18n.with_locale(with_locale) do
              self.url_fragment = self.name.parameterize
            end rescue nil
            #self.url_fragment = self.name.parameterize
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

  has_attached_file :avatar, styles: { popup: "350x350#", projects_list: "480x480#", thumb: "100x100#" }
  has_attached_file :thumb, styles: { thumb: "100x100#" }
  has_attached_file :item_top_banner_bg_image, styles: {large: "1920x980"}
  has_attached_file :item_top_banner_image
  has_attached_file :vs_banner

  has_attached_file :item_bottom_banner_bg_image, styles: {large: "1920x980"}
  has_attached_file :item_bottom_banner_image


  [:avatar, :item_top_banner_bg_image, :item_top_banner_image, :vs_banner, :thumb, :item_bottom_banner_bg_image, :item_bottom_banner_image].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
    do_not_validate_attachment_file_type attachment_name
  end

  def url(locale = I18n.locale)
    v = self.translations_by_locale[locale].url_fragment
    if !v.start_with?("/")
      v = "/#{v}"
    end

    "/#{locale}/projects#{v}"
  end

  def self.load_data_defaults(associations = {})
    defaults = 4.times.map do |i|
      item_defaults = {}

      [:project_case, :logo_and_ci, :ux_and_strategy, :responsive_web_design, :technical_side_of_project, :seo_strategy].each do |column_name|
        I18n.available_locales.each do |locale|
          locale = locale.to_sym
          item_defaults[:translations] = {}
          item_defaults[:translations][locale] = {}
          item_defaults[:translations][locale][column_name.to_sym] = Fake.html(locale: locale)
        end

      end

      item_defaults
    end
  end

  def self.load_data(associations = {})
    defaults = self.load_data_defaults(associations)
    LoadData.load_resources(self, associations, defaults)

    self.all.each do |item|
      [:project_case, :logo_and_ci, :ux_and_strategy, :responsive_web_design, :technical_side_of_project, :seo_strategy].each do |column_name|
        I18n.available_locales.each do |locale|
          locale = locale.to_sym
          item.translations_by_locale[locale].send("#{column_name}=", Fake.html(locale: locale))
        end
      end

      item.save
    end
  end
end
