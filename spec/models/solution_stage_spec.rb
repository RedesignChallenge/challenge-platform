# == Schema Information
#
# Table name: solution_stages
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

describe SolutionStage do

  it { is_expected.to belong_to(:challenge) }
  it { is_expected.to have_many(:solution_stories) }
  it { is_expected.to have_many(:solutions).through(:solution_stories) }

end
