module Embeddable
  extend ActiveSupport::Concern
  include LinkHelper

  included do
    after_save :update_embed_code
  end

  ## UPDATING METHODS

  def update_embed_code
    if self.link_changed? || self.embed.nil?
      if self.link.present?
        if IMAGE_EXTENSION_WHITELIST.any?{ |extension| self.link.end_with?(extension) }
          embed_code = ActionController::Base.helpers.image_tag(self.link, width: '100%')
        elsif ['youtube.com', 'youtu.be', 'vimeo.com'].any?{ |video| self.link.include?(video) }
          embed_code = video_embed(self.link)
        elsif self.link.include?('twitter.com')
          tweet_id = self.link.split('status/')[1]
          if tweet_id.present?
            twitter_rest_client = Twitter::REST::Client.new(TWITTER_CONFIG)
            tweet = twitter_rest_client.oembed(tweet_id)
            embed_code = tweet.html
          end
        end

        embed_code ? self.update_column(:embed, embed_code) : nil
      else
        self.update_column(:embed, nil)
      end
    end
  rescue
  end

end