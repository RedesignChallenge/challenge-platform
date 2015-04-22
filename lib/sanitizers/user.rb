class UserParameterSanitizer < Devise::ParameterSanitizer
  
  def sign_up
    default_params.permit(
      :first_name, 
      :last_name, 
      :email, 
      :password, 
      :remember_me, 
      :role, 
      :referrer_id
    )
  end

  def sign_in
    default_params.permit(
      :email, 
      :password, 
      :remember_me
    )
  end

  def account_update
    default_params.permit(
      :first_name, 
      :last_name, 
      :email, 
      :current_password, 
      :password, 
      :password_confirmation, 
      :display_name, 
      :twitter, 
      :avatar_option, 
      :avatar, 
      :remote_avatar_url, 
      :remove_avatar, 
      :avatar_cache, 
      :role, 
      :title, 
      :organization, 
      :bio, 
      { state_ids: [] }, 
      { district_ids: [] }, 
      { school_ids: [] },
      :comment_posted,
      :comment_replied
    )
  end

end