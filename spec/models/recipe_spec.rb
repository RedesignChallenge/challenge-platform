# == Schema Information
#
# Table name: recipes
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  materials               :text
#  link                    :text
#  image                   :string
#  file                    :text
#  embed                   :text
#  destroyed_at            :datetime
#  cookbook_id             :integer
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
require 'models/concerns/feature_concern'
require 'models/concerns/publishable_concern'
require 'models/concerns/default_ordering_concern'
require 'models/concerns/orderable_concern'

describe Recipe do

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  # it { is_expected.to validate_length_of(:description).is_at_most(2048)}
  # it { is_expected.to validate_length_of(:evidence).is_at_most(2048)}
  # it { is_expected.to validate_length_of(:protips).is_at_most(2048)}
  # it { is_expected.to validate_length_of(:materials).is_at_most(2048)}
  # it { is_expected.to validate_length_of(:community).is_at_most(2048)}
  # it { is_expected.to validate_length_of(:conditions).is_at_most(2048)}
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:cookbook) }
  it { is_expected.to belong_to(:refinement_parent).class_name('Recipe') }
  it { is_expected.to have_many(:refinements).class_name('Recipe').with_foreign_key('refinement_parent_id') }
  it { is_expected.to have_many(:steps) }
  it { is_expected.to have_one :feature }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
  it_behaves_like 'a publishable entity'
  it_behaves_like 'orderable'
  it_behaves_like 'an entity respecting the default order'

  let(:entity) {
    recipe_stage = FactoryGirl.create(:recipe_stage, challenge: challenge)
    cookbook = FactoryGirl.create(:cookbook, recipe_stage: recipe_stage)
    recipe = FactoryGirl.create(:recipe, cookbook: cookbook)

    recipe
  }

  it_behaves_like 'a featurable entity'

end
