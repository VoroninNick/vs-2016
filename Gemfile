source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use sqlite3 as the database for Active Record
gem 'activesupport', '4.2.4'
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', github: "turbolinks/turbolinks-classic"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

gem 'slim-rails'
gem 'bower-rails'

gem 'inline_svg'

gem 'globalize'

gem 'protected_attributes'

gem 'paperclip', '~> 4.2'
gem 'rails_admin'

local = ENV["LOCAL"] || __FILE__.start_with?("/media/data/pasha")

if local
  gem 'cms', path: "/media/data/pasha/gems/cms"
  gem 'attachable', path: "/media/data/pasha/gems/attachable"
  gem 'rails_admin_globalize_field', path: "/media/data/pasha/gems/rails_admin_globalize_field"
else
  gem 'cms', github: "pkorenev/cms"
  gem 'attachable', github: "VoroninNick/attachable"
  gem 'rails_admin_globalize_field', github: "VoroninNick/rails_admin_globalize_field", branch: "pasha"
end

gem 'rails_admin_nestable'

#gem 'thin'
gem 'puma'
gem 'quiet_assets'

gem 'ckeditor'

gem 'enumerize'

gem 'devise'

gem 'acts-as-taggable-on'

gem 'inky-rails', github: "pkorenev/inky-rails", branch: "slim-handler"

gem 'roadie-rails'

gem 'russian'

#gem 'ukrainian'

gem 'i18n'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# gem 'bcrypt'
gem 'bcrypt-ruby', '3.1.1.rc1', :require => 'bcrypt'

gem 'yaml_db'