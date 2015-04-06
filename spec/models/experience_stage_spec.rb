# == Schema Information
#
# Table name: experience_stages
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  active       :boolean
#  public       :boolean
#  starts_at    :datetime
#  ends_at      :datetime
#  challenge_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

describe ExperienceStage do

  it { is_expected.to belong_to(:challenge) }
  it { is_expected.to have_many(:themes) }
  it { is_expected.to have_many(:experiences).through(:themes) }

end  
