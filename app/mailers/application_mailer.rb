class ApplicationMailer < ActionMailer::Base
  default from: ENV["smtp_gmail_user_name"]
  layout 'mailer'

  def receivers(name)
    config_class = "FormConfigs::#{name.classify}".constantize
    to = config_class.first.try(&:emails) || config_class.default_emails
    to
  end

  def new_hire_us_request(hire_us_request)
    new_request(hire_us_request)
  end

  def new_join_us_request(join_us_request)
    new_request(join_us_request)
  end

  def new_request(obj)
    init_host
    set_admin_root
    @request = obj
    resource_name = @request.class.name.underscore
    @email_title = I18n.t("mailer.#{resource_name}.title")
    mail to: receivers(resource_name), subject: @email_title, template_name: "basic_request"
  end

  private

  def init_host
    @host = (ENV["#{Rails.env}.host_with_port"] || ENV["#{Rails.env}.host"])
  end

  def set_admin_root
    @admin_root = @host + "/admin"
  end
end
