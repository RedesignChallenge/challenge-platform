class UrlValidator < ActiveModel::EachValidator
  require 'public_suffix'

  MAX_LENGTH = 2047

  def validate_each(record, attribute, value)
    if value
      begin
        if value.size > MAX_LENGTH
          record.errors[attribute] << (options[:message] || "is too long, maximum length is #{MAX_LENGTH} characters")
          return
        end
        url = URI.parse(value)
        # kind_of?(URI.HTTP) covers both HTTP and HTTPS; url.scheme covers the schemeless URLs (e.g. youtube.com)
        unless url.kind_of?(URI::HTTP) || !url.scheme
          record.errors[attribute] << (options[:message] || "doesn't contain a valid scheme: #{value}")
          return
        end
        url.scheme = 'http'
        unless PublicSuffix.valid?(url.hostname || url.path )
          record.errors[attribute] << (options[:message] || "hostname is not valid: #{url.hostname}")
          return
        end
        public_suffix_url = PublicSuffix.parse(url.hostname || url.path)
        unless public_suffix_url.domain?
          record.errors[attribute] << (options[:message] || "domain is not valid: #{value}")
        end
      rescue URI::InvalidURIError
        record.errors[attribute] << (options[:message] || 'invalid URL')
      rescue PublicSuffix::DomainInvalid
        record.errors[attribute] << (options[:message] || "domain is not valid: #{value}")
      rescue PublicSuffix::DomainNotAllowed
        record.errors[attribute] << (options[:message] || "domain usage is not allowed by authority: #{value}")
      end
    end
  end
end