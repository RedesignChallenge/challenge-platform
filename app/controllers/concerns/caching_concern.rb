module CachingConcern
  extend ActiveSupport::Concern

  def cache_pending_object(object)
    clear_pending_cache
    session[:object] = object
  end

  def cache_pending_like(object, options = {})
    clear_pending_cache
    like = { likeable_type: object.class.name, likeable_id: object.id, vote_scope: options[:vote_scope], vote_weight: options[:vote_weight] }.reject { |_, value| value.nil? }
    session[:like] = like if like.has_value?(object.class.name) && like.has_value?(object.id)
  end

  private

  def clear_pending_cache
    session.delete(:like)
    session.delete(:object)
  end
end
