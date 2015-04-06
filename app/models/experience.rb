# == Schema Information
#
# Table name: experiences
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  image                   :string
#  link                    :text
#  featured                :boolean
#  top_comment             :boolean
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
#

class Experience < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :theme
  has_and_belongs_to_many :solutions

  acts_as_votable
  acts_as_commentable
  acts_as_paranoid column: :destroyed_at

  validates :description, presence: true, length: { maximum: 1024 }
  validates :link, url: true, allow_blank: true

  def experience_stage
    self.theme.experience_stage
  end

  def challenge
    self.experience_stage.challenge
  end

  def default_like
    DEFAULT_LIKE
  end

end
