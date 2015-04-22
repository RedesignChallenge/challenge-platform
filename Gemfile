source 'https://rubygems.org'
ruby '2.2.0'

## RAILS SETUP
gem 'rails', '4.2.1'
gem 'pg'
gem 'unicorn'
gem 'active_model_serializers'
gem 'uglifier'

## RAILS HELPERS
gem 'friendly_id'
gem 'numbers_and_words'
gem 'cocoon'

## FRONT END JS ASSETS
source 'https://rails-assets.org' do
  gem 'rails-assets-underscore'
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-sanitize'
  gem 'rails-assets-angular-animate'
  gem 'rails-assets-angular-ui-select2'
  gem 'rails-assets-angular-scroll'
end

## FRONT-END GEMS
gem 'jquery-rails'
gem 'coffee-rails'
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'select2-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'bootstrap-switch-rails'
gem 'bourbon', '~> 4.2.1'

## FILE/PHOTO UPLOADS
gem 'twitter'
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'carrierwave_backgrounder'

## VOTING
gem 'acts_as_votable', github: 'ryanto/acts_as_votable'

## COMMENTING
gem 'acts_as_commentable_with_threading', '~> 2.0.0'

## DELETING ENTITIES
gem 'paranoia', '~> 2.0'

## AUTHENTICATION/ADMINISTRATION
gem 'devise'
gem 'bcrypt'
gem 'rails_admin'
gem 'kaminari'

## MAILERS
gem 'mandrill-api'
gem 'mailkick'

## PERFORMANCE ENHANCEMENTS
gem 'multi_fetch_fragments'
gem 'newrelic_rpm'
gem 'memcachier'
gem 'dalli'

## DELAYED JOBS
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'devise-async'
gem 'exception_notification', '>= 4.1.0rc1'

## VALIDATOR HELPER
gem 'public_suffix', '~> 1.4.6'

## SEEDING DATA
gem 'faker'

## Local Environment
group :development do
  gem 'web-console'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'annotate'
end

group :development, :test do
  gem 'spring'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
end

group :test do
  gem 'webmock', '~> 1.20.4'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner', '~> 1.4.0'
end

group :production do
  gem 'rails_12factor'
end