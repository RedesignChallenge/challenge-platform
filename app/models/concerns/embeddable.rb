module Embeddable
  extend ActiveSupport::Concern
  include LinkHelper

  included do
    after_save :update_embed_code
  end

  ## UPDATING METHODS

  def update_embed_code
    begin
      if self.link_changed? || self.embed.nil?
        if self.link.present?
          begin
            if IMAGE_EXTENSION_WHITELIST.any? { |extension| self.link.end_with?(extension) }
              embed_code = ActionController::Base.helpers.image_tag(self.link, width: '100%')
            elsif %w(youtube.com youtu.be vimeo.com).any? { |video| self.link.include?(video) }
              embed_code = video_embed(self.link)
            elsif self.link.include?('twitter.com') && TWITTER_REST_CLIENT
              tweet_id = self.link.split('status/')[1]
              if tweet_id.present?
                tweet = TWITTER_REST_CLIENT.oembed(tweet_id)
                embed_code = tweet.html
              end
            end

            if embed_code
              self.update_columns(embed: embed_code)
            end
          rescue Exception => e
            logger.warn(e)
            raise e
          end
        else
          self.update_columns(embed: nil)
        end
      end
    rescue Exception => e
      logger.warn(e)
      raise e
    end
  end
end