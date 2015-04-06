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

FactoryGirl.define do
  factory :approach_stage, class: ApproachStage do
    title 'This is a sample title from FactoryGirl.'
    description 'This is a sample description from FactoryGirl.'
  end
end
