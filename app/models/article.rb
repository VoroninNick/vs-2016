class Article < ActiveRecord::Base
  attr_accessible *attribute_names
  has_cache

  has_and_belongs_to_many :authors, join_table: :author_articles, class_name: User, association_foreign_key: :author_id
  attr_accessible :authors, :author_ids

  globalize :name, :descriptive_name, :url_fragment, :description, :long_description, :content

  boolean_scope :published

  image :avatar, styles: { list_image: "530x330#", small_image: "100x100#" }

  has_tags
  has_seo_tags
  has_sitemap_record
  #has_cache



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

