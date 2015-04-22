# == Schema Information
#
# Table name: approach_stages
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  active       :boolean
#  public       :boolean
#  starts_at    :datetime
#  ends_at      :datetime
#  challenge_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  incentive    :text
#

class ApproachStage < ActiveRecord::Base
  belongs_to :challenge
  has_many :approach_ideas
  has_many :approaches, through: :approach_ideas


  def featured_approaches
    Feature.where(active: true,
                  featured_type: 'Approach',
                  featured_id: challenge.approach_stage.approaches.pluck(:id))
  end

  def featured_approach_comments
    Feature.where(active: true,
                  featured_type: 'Comment',
                  featured_id: Comment.where(commentable_id: challenge.approach_stage.approach_ideas.pluck(:id)))
  end
end
