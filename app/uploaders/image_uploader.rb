# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  # Choose what kind of storage to use for this uploader:
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :print do
    process resize_to_fit: [600, 400]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    IMAGE_EXTENSION_WHITELIST
  end

end