# == Schema Information
#
# Table name: features
#
#  id            :integer          not null, primary key
#  reason        :text
#  category      :string
#  active        :boolean
#  user_id       :integer
#  featured_id   :integer
#  featured_type :string
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :feature, class: Feature do
    reason 'This is a reason from FactoryGirl.'
  end
end
