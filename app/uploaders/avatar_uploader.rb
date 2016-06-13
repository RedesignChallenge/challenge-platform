# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  # Choose what kind of storage to use for this uploader:
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    if model.twitter.present?
      "http://avatars.io/twitter/#{model.twitter}?size=large"
    else
      "http://avatars.io/email/#{model.email}?size=large"
      # [version_name, "default.png"].compact.join('_')
    end
  end

  # Create different versions of your uploaded files:
  version :mini do
    process resize_to_fill: [24, 24]
  end

  version :thumb do
    process resize_to_fill: [52, 52]
  end

  version :profile do
    process resize_to_fill: [170, 170]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    IMAGE_EXTENSION_WHITELIST
  end
end
