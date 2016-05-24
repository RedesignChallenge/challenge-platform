# == Schema Information
#
# Table name: solutions
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  materials               :text
#  effort                  :string
#  link                    :text
#  embed                   :text
#  image                   :string
#  file                    :string
#  destroyed_at            :datetime
#  solution_story_id       :integer
#  user_id                 :integer
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
#  comments_count          :integer          default(0)
#  featured                :boolean          default(FALSE)
#  community               :text
#  conditions              :text
#  evidence                :text
#  protips                 :text
#

require 'rails_helper'
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'
require 'models/concerns/publishable_concern'
require 'models/concerns/feature_concern'
require 'models/concerns/default_ordering_concern'
require 'models/concerns/orderable_concern'

describe Solution do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:solution_story) }
  it { is_expected.to have_many(:steps) }
  it { is_expected.to have_and_belong_to_many(:experiences) }
  it { is_expected.to have_and_belong_to_many(:ideas) }
  it { is_expected.to have_and_belong_to_many(:recipes) }
  it { is_expected.to have_one :feature }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
  it_behaves_like 'a publishable entity'
  it_behaves_like 'orderable'
  it_behaves_like 'an entity respecting the default order'

  let(:entity) {
    solution_stage = FactoryGirl.create(:solution_stage, challenge: challenge)
    solution_story = FactoryGirl.create(:solution_story, solution_stage: solution_stage)
    solution = FactoryGirl.create(:solution, solution_story: solution_story)

    solution
  }

  it_behaves_like 'a featurable entity'
end
