class HireUsRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  validates_presence_of :name

  include Enumerize

  enumerize :budget_range, in: [:from_12k, :from_6k_to_12k, :from_3k_to_6k, :up_to_3k]

  def notify_admin
    ApplicationMailer.new_hire_us_request(self).deliver_now
  end
end