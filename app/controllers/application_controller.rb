class ApplicationController < ActionController::Base
  include RoutingConcern
  include CachingConcern
  include PersistenceConcern

  ## Callback
  before_action :capture_referrer_id
  after_action :set_csrf_cookie_for_ng

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  helper_method :resource, :resource_name, :devise_mapping

  def devise_parameter_sanitizer
    if resource_class == User
      UserParameterSanitizer.new(User, :user, params)
    else
      super # Use the default one
    end
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def hide_navs
    @hide_navs = true
  end

  def load_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  private

  def capture_referrer_id
    session[:referrer_id] = params[:referrer_id] if params[:referrer_id]
  end

  def object_flash_message_for(object, options = {})
    if object.destroyed_at?
      action = I18n.t('controllers.application.deleted')
    else
      if %w(experience idea recipe).include?(object.class.to_s.downcase)
        if object.published_at?
          action = if object.created_at == object.updated_at
                     I18n.t('controllers.application.shared')
                   else
                     options[:published] ? I18n.t('controllers.application.published') : I18n.t('controllers.application.updated')
                   end
        else
          action = object.created_at == object.updated_at ? I18n.t('controllers.application.saved_draft') : I18n.t('controllers.application.updated_draft')
        end
      else
        action = object.created_at == object.updated_at ? I18n.t('controllers.application.shared') : I18n.t('controllers.application.updated')
      end
    end

    message = I18n.t('controllers.application.message',
                     action: action,
                     actionable: object.class.name.downcase,
                     url: user_path(object.user))

    return message
  rescue
  end
end
