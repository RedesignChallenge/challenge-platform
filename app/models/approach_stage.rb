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
end
