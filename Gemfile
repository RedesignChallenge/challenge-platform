source 'https://rubygems.org'
ruby '2.2.4'

## RAILS SETUP
gem 'rails'
gem 'pg'
gem 'unicorn'
gem 'active_model_serializers'
gem 'uglifier'

## RAILS HELPERS
gem 'friendly_id'
gem 'numbers_and_words'
gem 'cocoon'
gem 'truncate_html'

## FRONT END JS ASSETS
source 'https://rails-assets.org' do
  gem 'rails-assets-underscore'
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-sanitize'
  gem 'rails-assets-angular-animate'
  gem 'rails-assets-angular-ui-select'
  gem 'rails-assets-angular-scroll'
end

## FRONT-END GEMS
gem 'jquery-rails'
gem 'coffee-rails'
gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'bootstrap-switch-rails'
gem 'bourbon'
gem 'select2-rails'

## FILE/PHOTO UPLOADS
gem 'twitter'
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'carrierwave_backgrounder'

## VOTING
gem 'acts_as_votable', github: 'ryanto/acts_as_votable'

## COMMENTING
gem 'acts_as_commentable_with_threading'

## DELETING ENTITIES
gem 'paranoia'

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

## INTERNATIONALIZATION
gem 'rails-i18n'
gem 'i18n-recursive-lookup'

## DELAYED JOBS
gem 'sidekiq'
gem 'sinatra'
gem 'devise-async'
gem 'exception_notification'

## VALIDATOR HELPER
gem 'public_suffix'

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
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'i18n-tasks'
end

group :test do
  gem 'webmock'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
end
