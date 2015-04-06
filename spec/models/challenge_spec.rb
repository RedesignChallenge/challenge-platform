# == Schema Information
#
# Table name: challenges
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  hashtag      :string
#  slug         :string
#  video_url    :string
#  ends_at      :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  background   :text
#  outcome      :text
#  help         :text
#  image        :string
#  starts_at    :datetime
#  active_stage :string
#  headline     :string
#  incentive    :text
#  cta          :string
#  banner       :string
#  featured     :boolean
#

require 'rails_helper'

describe Challenge do

  it { is_expected.to have_one(:panel) }
  it { is_expected.to have_one(:experience_stage) }
  it { is_expected.to have_one(:idea_stage) }
  it { is_expected.to have_one(:approach_stage) }
  it { is_expected.to have_one(:solution_stage) }

end
