# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  # Choose what kind of storage to use for this uploader:
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    FILE_EXTENSION_WHITELIST
  end

end
