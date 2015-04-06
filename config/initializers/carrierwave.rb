CarrierWave.configure do |config|
  ## FOR HEROKU
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines

  ## AWS CONFIG
  config.storage    =  :aws                   # required
  config.aws_bucket =  ENV['S3_BUCKET']       # required
  config.aws_acl    =  :public_read
  config.aws_credentials = {
    access_key_id:      ENV['S3_KEY'],        # required
    secret_access_key:  ENV['S3_SECRET'],     # required
    region:             ENV['S3_REGION']      # required  
  }

end