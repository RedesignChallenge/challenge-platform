# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  role                   :string
#  organization           :string
#  admin                  :boolean          default(FALSE)
#  ga_dimension           :string
#  title                  :string
#  video_access           :boolean          default(FALSE)
#  twitter                :string
#  avatar                 :string
#  future_participant     :boolean          default(TRUE)
#  color                  :string
#  bio                    :text
#  referrer_id            :integer
#  display_name           :string
#  avatar_option          :string           default("twitter")
#  notifications          :hstore           default({"comment_posted"=>"true", "comment_replied"=>"true", "comment_followed"=>"true"})
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :async,
         :recoverable, :rememberable, :trackable, :validatable

  ## Rails Admin
  rails_admin do
    configure :password do
      read_only true
    end
    configure :password_confirmation do
      read_only true
    end
  end

  has_and_belongs_to_many :states
  has_and_belongs_to_many :districts
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :panels
  has_many :experiences
  has_many :ideas
  has_many :recipes
  has_many :solutions
  has_many :comments
  has_many :suggestions
  belongs_to :referrer, class_name: "User", foreign_key: :referrer_id
  has_many :referrals, class_name: "User", foreign_key: :referrer_id
  store_accessor :notifications, :comment_replied, :comment_posted, :comment_followed

  mount_uploader :avatar, AvatarUploader
  process_in_background :avatar

  acts_as_voter
  mailkick_user

  before_create do |user|
    user.color = User::COLORS.sample
    user.display_name = "#{user.first_name} #{user.last_name[0]}"
  end

  before_save do |user|
    user.email = user.email.downcase
    user.twitter = user.twitter.sub('@', '') if user.twitter.present?
  end

  MAX_AVATAR_SIZE = 3

  ## VALIDATIONS
  validates :first_name, length: { maximum: 255 }, presence: true
  validates :last_name, length: { maximum: 255 }, presence: true
  validates :role, length: { maximum: 255 }, presence: true
  validates :display_name, length: { maximum: 255 }, presence: true, on: :update
  validates :organization, length: { maximum: 255 }, allow_blank: true
  validates :title, length: { maximum: 255 }, allow_blank: true
  validates :twitter, length: { maximum: 16 }, allow_blank: true
  validate :avatar_file_size

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def display_organization
    if self.organization.present?
      self.organization
    elsif self.schools.present?
      self.schools.first.name
    elsif self.districts.present?
      self.districts.first.name
    elsif self.states.present?
      self.states.first.name
    else
      ""
    end
  end

  def initials
    "#{self.first_name[0]}#{self.last_name[0]}"
  end

  def profile_complete?
    self.organization.present? || self.title.present? || self.twitter.present? || self.states.present? || self.districts.present? || self.schools.present?
  end

  def states_json
    self.states.to_json(only: [:id, :name, :mail_state])
  end

  def districts_json
    self.districts.to_json(only: [:id, :name, :location_city, :location_state])
  end

  def schools_json
    self.schools.to_json(only: [:id, :name, :location_city, :location_state])
  end

  def is_teacher?
    ['Current Teacher', 'Teacher Leader', 'Instructional Coach', 'School Leader'].include?(self.role)
  end

  def is_on_panel?(challenge)
    self.panels.exists?(challenge_id: challenge.id)
  end

  def has_draft_submissions?
    experiences.exists?(['published_at IS NULL']) || ideas.exists?(['published_at IS NULL']) || recipes.exists?(['published_at IS NULL']) || solutions.exists?(['published_at IS NULL'])
  end

  def set_avatar_from_twitter
    best_avatar_url = nil

    if self.twitter.present? && self.avatar_option == 'twitter'
      begin
        twitter_rest_client = Twitter::REST::Client.new(TWITTER_CONFIG)
        twitter_user_object = twitter_rest_client.user(self.twitter)
        best_avatar_url = twitter_user_object.profile_image_url_https.to_s.sub('_normal', '_400x400')
      rescue Twitter::Error::NotFound
        self.twitter = nil
      rescue Twitter::Error::RateLimited
        best_avatar_url = "http://avatars.io/twitter/#{self.twitter}?size=large"
      rescue
      end
    end

    self.remote_avatar_url = best_avatar_url
    self.save!
  rescue
  end

  ROLES = {
    I18n.t('activerecord.models.user.roles.pre_service_teacher_key') => 'Pre-Service Teacher',
    I18n.t('activerecord.models.user.roles.current_teacher_key') => 'Current Teacher',
    I18n.t('activerecord.models.user.roles.teacher_leader_key') => 'Teacher Leader',
    I18n.t('activerecord.models.user.roles.instructional_coach_key') => 'Instructional Coach',
    I18n.t('activerecord.models.user.roles.school_leader_key') => 'School Leader',
    I18n.t('activerecord.models.user.roles.district_staff_key') => 'LEA Staff',
    I18n.t('activerecord.models.user.roles.state_staff_key') => 'SEA Staff',
    I18n.t('activerecord.models.user.roles.other_key') => 'Other'
  }

  COLORS = %w(#11487e #8BB734 #7F3F98 #F26606)

  private

  def avatar_file_size
    if avatar && avatar.file && avatar.file.size.to_i > MAX_AVATAR_SIZE.megabytes.to_i
      errors.add(:avatar, "Avatar is too large; it must be smaller than #{MAX_AVATAR_SIZE} MB")
    end
  end

end
