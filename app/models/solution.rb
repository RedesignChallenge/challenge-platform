# == Schema Information
#
# Table name: solutions
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  needs                   :text
#  effort                  :string
#  link                    :text
#  embed                   :text
#  image                   :string
#  file                    :string
#  destroyed_at            :datetime
#  solution_story_id       :integer
#  user_id                 :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  published_at            :datetime
#

class Solution < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  include Publishable

  belongs_to :solution_story
  belongs_to :user
  has_many :steps, as: :steppable
  has_one :feature, as: :featured
  has_and_belongs_to_many :experiences
  has_and_belongs_to_many :ideas
  has_and_belongs_to_many :approaches

  mount_uploader :file, FileUploader
  process_in_background :file

  acts_as_votable
  acts_as_commentable
  acts_as_paranoid column: :destroyed_at

  def solution_stage
    self.solution_story.solution_stage
  end

  def challenge
    self.solution_stage.challenge
  end

  def default_like
    DEFAULT_LIKE
  end

  def icon
    'fa-puzzle-piece'
  end

end
