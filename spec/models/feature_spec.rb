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

require 'rails_helper'

describe Feature do

  let(:non_admin_user)  { FactoryGirl.create(:user) }
  let(:admin_user)  { FactoryGirl.create(:user, admin: true) }
  let(:feature) { FactoryGirl.create(:feature) }

  it { is_expected.to belong_to :featureable }
  it { is_expected.to belong_to :user }
end
