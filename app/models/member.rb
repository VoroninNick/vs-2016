class Member < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :role, :few_words_about



  has_attached_file :image, styles: { about_image: "520x624#", thumb: "100x120#" }
  [:image].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
    do_not_validate_attachment_file_type attachment_name
  end

  boolean_scope :published
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    sort_by_sorting_position
  end

  has_cache do
    pages :about_us
  end
end
