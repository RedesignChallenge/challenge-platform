TWITTER_CONFIG = {
  consumer_key:         ENV['TWITTER_CONSUMER_KEY'],
  consumer_secret:      ENV['TWITTER_CONSUMER_SECRET'],
  access_token:         ENV['TWITTER_ACCESS_TOKEN'],
  access_token_secret:  ENV['TWITTER_ACCESS_SECRET']
}

puts Rails.env
if !TWITTER_CONFIG.values.include? nil
  TWITTER_REST_CLIENT = Twitter::REST::Client.new(TWITTER_CONFIG)
elsif Rails.env.test?
  TWITTER_REST_CLIENT = Twitter::REST::Client.new(TWITTER_CONFIG)
else
  TWITTER_REST_CLIENT = nil
end
