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
#

FactoryGirl.define do
  factory :idea_stage, class: IdeaStage do

  end
end
