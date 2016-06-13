module PersistenceConcern
  extend ActiveSupport::Concern

  def persist_pending_cache
    persist_pending_like if session[:like].present?
    persist_pending_object if session[:object].present?
    clear_persisted_cache
  end

  private

  def persist_pending_like
    like = session[:like]
    likeable = eval("#{like[:likeable_type].titleize}.find_by(id: #{like[:likeable_id]})")
    if likeable && likeable.liked_by(current_user, vote_scope: like[:vote_scope], vote_weight: like[:vote_weight])
      flash[:success] = I18n.t('concerns.persistence.flash.success',
                               action: like[:vote_weight].present? ? I18n.t('concerns.persistence.voted_for') : I18n.t('concerns.persistence.liked'),
                               likeable: likeable.class.name.downcase)
      store_location_for(:user, after_update_object_path_for(likeable))
    end
  rescue
  end

  def persist_pending_object
    object = session[:object]
    object.user = current_user
    if object.save
      object.send_notifications if object.class == Comment && !Rails.env.development?
      flash[:success] = object_flash_message_for(object)
      store_location_for(:user, after_update_object_path_for(object))
    end
  rescue
  end

  def clear_persisted_cache
    session.delete(:like)
    session.delete(:object)
  end
end
