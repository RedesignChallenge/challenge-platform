CarrierWave.configure do |config|
  ## FOR HEROKU
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines

  ## AWS CONFIG
  config.storage    =  :aws                   # required
  config.aws_acl    =  'public-read'          # required
  config.aws_bucket =  ENV['S3_BUCKET']       # required
  config.aws_credentials = {
    access_key_id:      ENV['S3_KEY'],        # required
    secret_access_key:  ENV['S3_SECRET'],     # required
    region:             ENV['S3_REGION']      # required  
  }
end

#
# if Rails.env.test?
# # Stub out CarrierWave so that we can test user avatars without uploading anything
#   CarrierWave.configure do |config|
#     config.storage = :file
#     config.enable_processing = false
#     config.aws_bucket = 'test'
#   end
#
#   # Add any uploader here that we need to be auto-loaded for our testing purposes.
#   AvatarUploader
#
#   CarrierWave::Uploader::Base.descendants.each do |klass|
#     next if klass.anonymous?
#     klass.class_eval do
#       def cache_dir
#         "#{Rails.root}/spec/support/uploads/tmp"
#       end
#
#       def store_dir
#         "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#       end
#     end
#   end
# end