class Technology < ActiveRecord::Base
  attr_accessible *attribute_names

  has_and_belongs_to_many :projects
  attr_accessible :projects, :project_ids

  has_attached_file :icon, validate_media_type: false

  [:icon].each do |attachment_name|
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
    do_not_validate_attachment_file_type attachment_name
  end

end
