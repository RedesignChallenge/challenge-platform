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

FactoryGirl.define do
  factory :approach_idea, class: ApproachIdea do
    sequence(:title) { |n| "Title ##{n}"}
    sequence(:description) { |n| "Description ##{n}"}
  end

  trait 'with_approaches' do

    transient do
      user nil
      amount 1
    end

    after :create do |approach_idea, evaluator|
      approach_idea.approaches = FactoryGirl.create_list(:approach, evaluator.amount, user: evaluator.user)
    end
  end
end
