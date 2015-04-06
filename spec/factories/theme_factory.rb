# == Schema Information
#
# Table name: themes
#
#  id                  :integer          not null, primary key
#  title               :string
#  description         :text
#  experience_stage_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

FactoryGirl.define do
  factory :theme, class: Theme do

  end
end
