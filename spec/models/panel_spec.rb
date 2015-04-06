# == Schema Information
#
# Table name: panels
#
#  id           :integer          not null, primary key
#  about        :text
#  challenge_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

describe Panel do

  it { is_expected.to belong_to(:challenge) }
  it { is_expected.to have_and_belong_to_many(:users) }

end
