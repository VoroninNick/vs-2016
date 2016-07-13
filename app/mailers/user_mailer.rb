class UserMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  layout 'mailer'

  def hello
    # mail(to: 'partido12@gmail.com', subject: 'test', template_path: "short") do |format|
    #   format.text
    #   format.inky
    # end

    mail(to: 'partido12@gmail.com', subject: 'test') do |format|
      format.text
      format.inky
    end
  end
end
