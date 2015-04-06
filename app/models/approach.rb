# == Schema Information
#
# Table name: approaches
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  needs                   :text
#  link                    :text
#  image                   :string
#  file                    :text
#  embed                   :text
#  destroyed_at            :datetime
#  approach_idea_id        :integer
#  user_id                 :integer
#  refinement_parent_id    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#

class Approach < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  default_scope { order(created_at: :asc) }

  belongs_to :approach_idea
  belongs_to :user
  has_many :steps, as: :steppable
  has_many :refinements, class_name: 'Approach', foreign_key: 'refinement_parent_id'
  belongs_to :refinement_parent, class_name: 'Approach'
  has_and_belongs_to_many :solutions

  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: lambda { |step| step['description'].blank? }

  acts_as_votable
  acts_as_commentable
  acts_as_paranoid column: :destroyed_at

  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 1024 }
  validates :needs, length: { maximum: 1024 }, allow_blank: true
  validates :link, url: true, allow_blank: true

  def approach_stage
    self.approach_idea.approach_stage
  end

  def challenge
    self.approach_stage.challenge
  end

  def default_like
    DEFAULT_LIKE
  end

end
