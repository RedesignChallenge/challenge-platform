# == Schema Information
#
# Table name: approaches
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  needs                   :text
#  link                    :text
#  image                   :string
#  file                    :text
#  embed                   :text
#  destroyed_at            :datetime
#  approach_idea_id        :integer
#  user_id                 :integer
#  refinement_parent_id    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  published_at            :datetime
#

require 'rails_helper'
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'
require 'models/concerns/feature_concern'
require 'models/concerns/publishable_concern'

describe Approach do

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:description).is_at_most(1024)}
  it { is_expected.to validate_length_of(:needs).is_at_most(1024)}
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:approach_idea) }
  it { is_expected.to belong_to(:refinement_parent).class_name('Approach') }
  it { is_expected.to have_many(:refinements).class_name('Approach').with_foreign_key('refinement_parent_id') }
  it { is_expected.to have_many(:steps) }
  it { is_expected.to have_one :feature }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
  it_behaves_like 'a publishable entity'

  let(:entity) {
    approach_stage = FactoryGirl.create(:approach_stage, challenge: challenge)
    approach_idea = FactoryGirl.create(:approach_idea, approach_stage: approach_stage)
    approach = FactoryGirl.create(:approach, approach_idea: approach_idea)

    approach
  }

  it_behaves_like 'a featurable entity'

end
