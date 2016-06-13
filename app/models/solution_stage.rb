# == Schema Information
#
# Table name: solution_stages
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
#

class SolutionStage < ActiveRecord::Base
  belongs_to :challenge
  has_many :solution_stories
  has_many :solutions, through: :solution_stories
end
