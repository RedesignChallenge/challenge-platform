module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> (user = nil) {
      if user and user.id
        where('published_at IS NOT NULL OR user_id = ?', user.id)
      else
        where.not(published_at: nil)
      end
    }
  end
end
