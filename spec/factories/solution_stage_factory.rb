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

FactoryGirl.define do
  factory :solution_stage, class: SolutionStage do
    title 'This is a solution stage title from FactoryGirl.'
    description 'This is a solution stage from FactoryGirl.'
  end

end
