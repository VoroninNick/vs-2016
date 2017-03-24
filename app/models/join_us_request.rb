class JoinUsRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  #has_attached_file :portfolio_attachment
  pdf :portfolio_attachment

  include Enumerize
  enumerize :desired_vacancy,
            in: [:web_designer, :graphic_designer, :ror_developer, :html_css_developer, :copywriter, :sales_manager, :cool_guy],
            default: :web_designer

  def notify_admin
    ApplicationMailer.new_join_us_request(self).deliver_now
  end
end