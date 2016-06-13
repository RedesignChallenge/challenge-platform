class RegistrationsController < Devise::RegistrationsController

  def edit
    set_edit_setting
  end

  #
  # Update a user registration
  #
  # This method is overridden from the Devise method call because we need to parse the
  # strings of district ids
  def update
    set_edit_setting
    check_password_needed
    # We're persisting the check before the super block.
    # If we do not, the existing resource values will be the same as the params.
    avatar_updated = avatar_updated?

    super do |resource|
      if resource.errors.empty?
        update_avatar(resource) if avatar_updated
      end
    end
  end

  private

  #
  # Parse both district_ids into arrays
  #
  # Affects the params instance variable, does not return anything.
  def check_password_needed
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      params[:user].delete(:current_password)
    end
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    if params[:password].nil?
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def set_edit_setting
    @setting = params[:user] ? params[:user][:setting] : params[:setting]
    @setting = 'profile' unless @setting && %w(profile account onboard notifications).include?(@setting)
  end

  def after_update_path_for(resource)
    edit_user_registration_path(setting: (@setting == 'onboard' ? 'profile' : "#{@setting}"))
  end

  def update_avatar(resource)
    if params[:user][:avatar_option] == 'none'
      resource.remove_avatar!
      resource.save
    else
      resource.delay.set_avatar_from_twitter
    end
  end

  def avatar_updated?
    twitter_changed = resource.twitter != params[:user][:twitter] || (params[:user][:avatar_option] == 'twitter' && resource.avatar_option != 'twitter')
    remove_avatar = resource.avatar.present? && params[:user][:avatar_option] == 'none'
    twitter_changed || remove_avatar
  end
end
