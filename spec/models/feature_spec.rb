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

require 'rails_helper'

describe Feature do

  let(:non_admin_user)  { FactoryGirl.create(:user) }
  let(:admin_user)  { FactoryGirl.create(:user, admin: true) }
  let(:feature) { FactoryGirl.create(:feature) }

  it { is_expected.to belong_to :featured }
  it { is_expected.to belong_to :user }
end
