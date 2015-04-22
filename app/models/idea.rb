# == Schema Information
#
# Table name: ideas
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  link                    :text
#  image                   :string
#  file                    :string
#  embed                   :text
#  problem_statement_id    :integer
#  user_id                 :integer
#  refinement_parent_id    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  destroyed_at            :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  impact                  :text
#  implementation          :text
#  published_at            :datetime
#

class Idea < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  include Publishable

  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :problem_statement
  has_many :refinements, class_name: 'Idea', foreign_key: 'refinement_parent_id'
  belongs_to :refinement_parent, class_name: 'Idea'
  has_and_belongs_to_many :solutions
  has_one :feature, as: :featured
  
  acts_as_votable
  acts_as_commentable
  acts_as_paranoid column: :destroyed_at

  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 1024 }
  validates :impact, length: { maximum: 1024 }, allow_blank: true
  validates :implementation, length: { maximum: 1024 }, allow_blank: true
  validates :link, url: true, allow_blank: true

  def idea_stage
    self.problem_statement.idea_stage
  end

  def challenge
    self.idea_stage.challenge
  end

  def default_like
    DEFAULT_LIKE
  end

  def icon
    'fa-lightbulb-o'
  end

end
