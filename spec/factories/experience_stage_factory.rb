# == Schema Information
#
# Table name: experience_stages
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
  factory :experience_stage, class: ExperienceStage do

  end
end
