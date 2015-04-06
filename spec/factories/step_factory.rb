# == Schema Information
#
# Table name: steps
#
#  id             :integer          not null, primary key
#  display_order  :integer
#  title          :string
#  description    :text
#  steppable_id   :integer
#  steppable_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :step, class: Step do
    description 'This is a test description from FactoryGirl.'
  end

  trait :with_order do
    sequence(:display_order) { |n| n }
  end
end
