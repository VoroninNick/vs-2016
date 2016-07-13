# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'load_data'
#require_relative "../lib/load_data.rb"

def load_projects
  service_ids = Service.pluck :id
  Project.load_data(service_ids: service_ids)
end

load_projects

Technology.send :extend, LoadData::ClassMethods
Technology.load_data



