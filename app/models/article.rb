class Article < ActiveRecord::Base
  attr_accessible *attribute_names
  has_cache

  has_and_belongs_to_many :authors, join_table: :author_articles, class_name: User, association_foreign_key: :author_id
  attr_accessible :authors, :author_ids

  def self.initialize_globalize
    translates :name, :descriptive_name, :url_fragment, :description, :long_description, :content
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes
    resource_class = self
    resource_association_name = resource_class.name.split("::").last.underscore.to_sym

    Translation.class_eval do
      self.table_name = :"#{resource_association_name}_translations"
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

  boolean_scope :published

  image :avatar, styles: { list_image: "530x330#", small_image: "100x100#" }

  has_tags



  def initialize_release_date
    if self.published
      if self.release_date.blank?
        self.release_date = Date.today
      end
    else
      self.release_date = nil
    end
  end

  before_validation :initialize_release_date

end

