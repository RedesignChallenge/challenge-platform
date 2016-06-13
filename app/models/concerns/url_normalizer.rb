module URLNormalizer
  extend ActiveSupport::Concern

  included do
    before_save :normalize_url
  end

  def normalize_url
    self.link = "http://#{self.link}" unless self.link=~/^https?:\/\// || self.link.blank?
  end
end
