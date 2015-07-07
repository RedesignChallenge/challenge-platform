class ApplicationController < ActionController::Base
  include RoutingConcern
  include CachingConcern
  include PersistenceConcern
  include HttpAcceptLanguage::AutoLocale


 


  ## Callback
  before_action :authenticate_user!, if: Proc.new { ENV['SITE_LOCKED'] == 'true' }
  before_action :capture_referrer_id
  after_action :set_csrf_cookie_for_ng
  after_action :set_ga_dimension_session
  before_action :set_locale

  
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def set_ga_dimension_session
    session[:cp_ga_dimension] = params[:ref] if params[:ref].present? && session[:cp_ga_dimension].nil?
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
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def hide_navs
    @hide_navs = true
  end

  def load_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

private

  def capture_referrer_id
    session[:referrer_id] = params[:referrer_id] if params[:referrer_id]
  end

  def object_flash_message_for(object, options = {})
    if object.destroyed_at?
      action = 'deleted'
    else
      if ['experience','idea','approach'].include?(object.class.to_s.downcase)
        if object.published_at?
          action = object.created_at == object.updated_at ? 'shared' : options[:published] ? 'published' : 'updated'
        else
          action = object.created_at == object.updated_at ? 'saved a draft of' : 'updated the draft of'
        end
      else
        action = object.created_at == object.updated_at ? 'shared' : 'updated'
      end
    end

    message = "You've successfully #{action} your #{object.class.name.downcase}. <a href='#{user_path(object.user)}'>Click here</a> to see all of your contributions."

    return message
  rescue
  end

end