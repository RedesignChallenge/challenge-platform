class DeviseMailerPreview < ActionMailer::Preview
  include Devise::Controllers::UrlHelpers

  # hit http://localhost:3000/rails/mailers/devise/mailer/confirmation_instructions
  def confirmation_instructions
    DeviseMailer.confirmation_instructions(User.first, 'faketoken')
  end
 
  # hit http://localhost:3000/rails/mailers/devise/mailer/reset_password_instructions
  def reset_password_instructions
    DeviseMailer.reset_password_instructions(User.first, 'faketoken')
  end
 
  # hit http://localhost:3000/rails/mailers/devise/mailer/unlock_instructions
  def unlock_instructions
    DeviseMailer.unlock_instructions(User.first, 'faketoken')
  end
  
end