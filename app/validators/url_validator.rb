class UrlValidator < ActiveModel::EachValidator
  require 'public_suffix'

  MAX_LENGTH = 2047

  def validate_each(record, attribute, value)
    if value
      begin
        if value.size > MAX_LENGTH
          record.errors[attribute] << (options[:message] || I18n.t('validators.url.too_long', length: MAX_LENGTH))
          return
        end
        url = URI.parse(value)
        # kind_of?(URI.HTTP) covers both HTTP and HTTPS; url.scheme covers the schemeless URLs (e.g. youtube.com)
        unless url.kind_of?(URI::HTTP) || !url.scheme
          record.errors[attribute] << (options[:message] || I18n.t('validators.url.invalid_scheme', value: value))
          return
        end
        url.scheme = 'http'
        unless PublicSuffix.valid?(url.hostname || url.path )
          record.errors[attribute] << (options[:message] || I18n.t('validators.url.invalid_hostname', hostname: url.hostname))
          return
        end
        public_suffix_url = PublicSuffix.parse(url.hostname || url.path)
        unless public_suffix_url.domain?
          record.errors[attribute] << (options[:message] || I18n.t('validators.url.invalid_domain', domain: value))
        end
      rescue URI::InvalidURIError
        record.errors[attribute] << (options[:message] || I18n.t('validators.url.invalid_url'))
      rescue PublicSuffix::DomainInvalid
        record.errors[attribute] << (options[:message] || I18n.t('validators.url.invalid_domain', domain: value))
      rescue PublicSuffix::DomainNotAllowed
        record.errors[attribute] << (options[:message] || I18n.t('validators.url.domain_not_allowed', value: value))
      end
    end
  end
end