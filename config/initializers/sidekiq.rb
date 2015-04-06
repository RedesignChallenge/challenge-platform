Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { size: 9 }

  database_url = ENV['DATABASE_URL']
  concurrency = ENV['SIDEKIQ_CONCURRENCY'] || 5
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{concurrency}"
    ActiveRecord::Base.establish_connection
  end
end
