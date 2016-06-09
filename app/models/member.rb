class Member < ActiveRecord::Base
  def self.initialize_globalize
    translates :name, :role, :few_words_about
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

  has_attached_file :image, styles: { about_image: "500x600#", thumb: "100x120#" }
  [:image].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
    do_not_validate_attachment_file_type attachment_name
  end

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
end
