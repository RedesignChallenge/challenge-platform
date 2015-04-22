class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper
  include Rails.application.routes.url_helpers
  def self.default_url_options
    ActionMailer::Base.default_url_options
  end

  default from: "#{I18n.t(:project_name)} <#{ENV['GMAIL_USERNAME']}>"
  default content_type: "text/html"
  layout 'mailer'

  before_action :set_action_and_header
  after_action  :set_recipient_and_send

private

  def set_action_and_header
    @action = action_name
    @header = "#{mailer_name.split('_')[0]} #{action_name}"
    message[:mailkick_list] = "#{mailer_name.split('_')[0]}_#{action_name}"
  end

  def set_recipient_and_send
    unless @resource.nil?
      @recipient = %("#{@resource.name}" <#{@resource.email}>)
      mail(to: @recipient, subject: @subject)
    end
  end

end