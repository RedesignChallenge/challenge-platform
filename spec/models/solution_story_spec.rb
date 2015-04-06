# == Schema Information
#
# Table name: solution_stories
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  link              :text
#  embed             :text
#  image             :string
#  destroyed_at      :datetime
#  solution_stage_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper' 
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'

describe SolutionStory do

  it { is_expected.to belong_to(:solution_stage) }
  it { is_expected.to have_one(:solution) }
  
  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
end
