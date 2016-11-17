class Client < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :short_description, :url, :avatar_alt

  image :avatar, path: ":rails_root/public:url",
      url: "/system/clients/:id/:style/:filename"

  boolean_scope :published
end
