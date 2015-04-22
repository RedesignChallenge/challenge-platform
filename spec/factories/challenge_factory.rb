# == Schema Information
#
# Table name: challenges
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  hashtag      :string
#  slug         :string
#  video_url    :string
#  ends_at      :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  background   :text
#  outcome      :text
#  help         :text
#  image        :string
#  starts_at    :datetime
#  active_stage :string
#  headline     :string
#  incentive    :text
#  cta          :string
#  banner       :string
#  featured     :boolean
#

FactoryGirl.define do
  factory :challenge, class: Challenge do
    title 'The Test Challenge'
  end

  trait :with_panelists do
    transient do
      panelists nil
    end

    after :create do |challenge, evaluator|
      challenge.panel = Panel.new(users: evaluator.panelists)
    end
  end
end
