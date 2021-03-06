require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dev
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    I18n.available_locales = [:en, :uk, :ru]

    Rails.application.config.assets.precompile += %w(ckeditor/filebrowser/images/*)
    Rails.application.config.assets.precompile += %w(mailer.css)

    #I18n.load_path += Dir.glob( File.dirname(__FILE__) + "config/locales/pages/*.{rb,yml}" )
    config.i18n.load_path += Dir[Rails.root.join("config/locales/pages/*.yml").to_s]
    config.i18n.load_path += Dir[Rails.root.join("config/locales/projects/*.yml").to_s]

    # file_editor
    config.assets.precompile += %w(fonts/octicons/octicons.woff cms/file_editor.css cms/file_editor.js)
  end
end
