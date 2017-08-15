class AboutSlide < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_file :image, styles: { slide: "1920x1080#", thumb: "192x108#" }
  [:image].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
    do_not_validate_attachment_file_type attachment_name
  end

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  has_cache do
    pages :about_us
  end


end
