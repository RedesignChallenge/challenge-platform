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
#  notifications          :hstore           default({"comment_posted"=>"true", "comment_replied"=>"true"})
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :async,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :states
  has_and_belongs_to_many :districts
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :panels
  has_many :experiences
  has_many :ideas
  has_many :approaches
  has_many :solutions
  has_many :comments
  has_many :suggestions
  belongs_to :referrer, class_name: "User", foreign_key: :referrer_id
  has_many :referrals,  class_name: "User", foreign_key: :referrer_id
  store_accessor :notifications, :comment_replied, :comment_posted

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
    user.twitter = user.twitter.sub('@','') if user.twitter.present?
  end

  MAX_AVATAR_SIZE = 3

  ## REQUIRED
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :role, presence: true, length: { maximum: 255 }
  validates :display_name, presence: true, length: { maximum: 255 }, on: :update

  ## OPTIONAL
  validates :organization, length: { maximum: 255 }
  validates :title, length: { maximum: 255 }
  validates :twitter, length: { maximum: 16 }
  validates :bio, length: { maximum: 2047 }

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

  def has_draft_submissions?
    experiences.exists?(['published_at IS NULL']) || ideas.exists?(['published_at IS NULL']) || approaches.exists?(['published_at IS NULL']) || solutions.exists?(['published_at IS NULL'])
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

  # <p class='select-help'>I am currently training to be a teacher in a whole class, resource, or one-on-one setting.</p>
  # <p class='select-help'>I am currently working with a whole class in a classroom, in small groups in a resource room, or one-on-one inside or outside a regular classroom.</p>
  # <p class='select-help'>I am currently a teacher and I spend a portion of my time supporting other adults in my school.</p>
  # <p class='select-help'>I spend the majority of my time supporting the professional development of adults in my school.</p>
  # <p class='select-help'>I am an administrator in a school (principal, assistant principal, dean, etc.).</p>

  ROLES = {
      "<p class='select-option'>Pre-Service Teacher</p>" => 'Pre-Service Teacher',

      "<p class='select-option'>Current Teacher</p>" => 'Current Teacher',

      "<p class='select-option'>Teacher Leader</p>" => 'Teacher Leader',

      "<p class='select-option'>Instructional Coach</p>" => 'Instructional Coach',
      
      "<p class='select-option'>School Leader</p>" => 'School Leader',

      "<p class='select-option'>District or CMO Staff</p>" => 'LEA Staff',

      "<p class='select-option'>State Educational Agency Staff</p>" => 'SEA Staff',

      "<p class='select-option'>Other</p>" => 'Other'
    }

  COLORS = %w(#11487e #8BB734 #7F3F98 #F26606)

  private
  def avatar_file_size
    if avatar && avatar.file && avatar.file.size.to_i > MAX_AVATAR_SIZE.megabytes.to_i
      errors.add("Avatar is too large; it must be smaller than #{MAX_AVATAR_SIZE} MB")
    end
  end
end
