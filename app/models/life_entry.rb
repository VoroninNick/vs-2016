class LifeEntry < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :description
  boolean_scope :published
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  image :image, styles: { image: "688x430#" }
end
