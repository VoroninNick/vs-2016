class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  def self.initialize_globalize
    translates :name, :url_fragment, :description, :content
    accepts_nested_attributes_for :translations
    attr_accessible :translations, :translations_attributes

    Translation.class_eval do
      self.table_name = :product_translations
      attr_accessible *attribute_names
      belongs_to :service, class_name: "Service"

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

  # attachents

  has_attached_file :icon
  has_attached_file :home_bg, styles: { xxl: "840x420#" }
  has_attached_file :list_image

  [:icon, :home_bg, :list_image].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
  end
end
