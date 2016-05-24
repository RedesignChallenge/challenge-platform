# == Schema Information
#
# Table name: idea_stages
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

class IdeaStage < ActiveRecord::Base
  belongs_to :challenge
  has_many :problem_statements
  has_many :ideas, through: :problem_statements

end
