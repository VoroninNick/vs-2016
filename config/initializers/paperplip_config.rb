if ENV['imagemagick_path'].present?
  Paperclip.options[:command_path] = ENV['imagemagick_path']
end
Paperclip::Attachment.default_options[:url] = "/system/:base_class/:attachment/:id_partition/:style/:filename"

Paperclip.interpolates('base_class') do |attachment, style|
  c = attachment.instance.class
  if c.superclass != ActiveRecord::Base && c.subclass_of?(ActiveRecord::Base)
    c = c.parent_classes(ActiveRecord::Base).last
  end

  c.name.underscore.pluralize
end