if Rails.env.production?
  CarrierWave.configure do |config|
    ## FOR HEROKU
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'

    ## AWS CONFIG
    config.storage = :aws
    config.aws_acl = 'public-read'
    config.aws_bucket = ENV['S3_BUCKET']
    config.aws_credentials = {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET'],
      region: ENV['S3_REGION']
    }
  end
elsif Rails.env.test?
  CarrierWave.configure do |config|
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.cache_dir = 'carrierwave'
    config.storage :file
    config.enable_processing = true
  end
end
