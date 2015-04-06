# == Schema Information
#
# Table name: approach_ideas
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  approach_stage_id :integer
#  idea_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class ApproachIdea < ActiveRecord::Base
  belongs_to :approach_stage
  belongs_to :idea
  has_many :approaches
  acts_as_commentable

  def challenge
    self.approach_stage.challenge
  end
end
