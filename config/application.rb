require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChallengePlatform
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_controller.asset_host = "#{ENV['SITE_PROTOCOL']}://#{ENV['SITE_HOST']}"
    config.action_mailer.asset_host     = "#{ENV['SITE_PROTOCOL']}://#{ENV['SITE_HOST']}"
    config.action_mailer.default_url_options = { host: "#{ENV['SITE_HOST']}", protocol: "#{ENV['SITE_PROTOCOL']}" }
    config.mandrill_mailer.default_url_options = { host: "#{ENV['SITE_HOST']}", protocol: "#{ENV['SITE_PROTOCOL']}" }

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib/modules)

    # Creates test suites for rspec
    config.generators { |generator| generator.test_framework(:rspec) }

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
