source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.6'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '5.4.3'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rexml'
gem 'dotenv-rails'
gem 'devise'
gem 'devise-i18n'
gem 'rails_admin', '~> 3.0'
gem 'cancancan'
gem 'carrierwave', '~> 3.0'
gem 'mini_magick'
gem 'fog-aws'
gem 'ransack'
gem 'rspotify'
gem 'impressionist',
  git: 'git@github.com:charlotte-ruby/impressionist.git',
  ref: '46a582ff8cd3496da64f174b30b91f9d97e86643'
gem 'whenever', require: false
gem 'net-smtp' 
gem 'net-imap' 
gem 'net-pop'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'spring'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'letter_opener_web'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
