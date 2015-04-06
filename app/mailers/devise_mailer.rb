class DeviseMailer < Devise::Mailer
  layout 'mailer'

  before_action { @header = "#{action_name.split('_').join(' ')}" }
end