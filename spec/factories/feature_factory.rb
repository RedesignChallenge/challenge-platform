# == Schema Information
#
# Table name: features
#
#  id               :integer          not null, primary key
#  reason           :text
#  category         :string
#  active           :boolean
#  user_id          :integer
#  featureable_id   :integer
#  featureable_type :string
#  created_at       :datetime
#  updated_at       :datetime
#  challenge_id     :integer          not null
#

FactoryGirl.define do
  factory :feature, class: Feature do
    reason 'This is a reason from FactoryGirl.'
  end
end
