# == Schema Information
#
# Table name: experiences
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  image                   :string
#  link                    :text
#  featured                :boolean          default(FALSE)
#  user_id                 :integer
#  theme_id                :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  embed                   :text
#  destroyed_at            :datetime
#  published_at            :datetime
#  comments_count          :integer          default(0)
#

class Experience < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  include Publishable
  include Orderable

  belongs_to :user
  belongs_to :theme
  has_and_belongs_to_many :solutions
  has_one :feature, as: :featureable

  acts_as_votable
  acts_as_commentable
  acts_as_paranoid column: :destroyed_at

  validates :description, presence: true
  validates :link,        url: true, allow_blank: true

  def title
    self.description.present? ? self.description.truncate(50) : nil
  end

  def experience_stage
    self.theme.experience_stage
  end

  def challenge
    self.experience_stage.challenge
  end

  def default_like
    DEFAULT_LIKE
  end

  def icon
    'fa-comment'
  end

end
