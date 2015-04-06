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

require 'rails_helper'

describe Theme do

  it { is_expected.to have_many(:experiences) }
  it { is_expected.to belong_to(:experience_stage) }

end
