CarrierWave::Backgrounder.configure do |config|
  config.backend :sidekiq, queue: :default, retry: false
end
