# == Schema Information
#
# Table name: experiences
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  image                   :string
#  link                    :text
#  featured                :boolean          default(FALSE)
#  user_id                 :integer
#  theme_id                :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  embed                   :text
#  destroyed_at            :datetime
#  published_at            :datetime
#  comments_count          :integer          default(0)
#

require 'rails_helper'
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'
require 'models/concerns/publishable_concern'
require 'models/concerns/feature_concern'
require 'models/concerns/default_ordering_concern'
require 'models/concerns/orderable_concern'

describe Experience do

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:description) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:theme) }
  it { is_expected.to have_one :feature }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
  it_behaves_like 'a publishable entity'
  it_behaves_like 'orderable'
  it_behaves_like 'an entity respecting the default order'

  let(:entity) {
    experience_stage = FactoryGirl.create(:experience_stage, challenge: challenge)
    theme = FactoryGirl.create(:theme, experience_stage: experience_stage)
    experience = FactoryGirl.create(:experience, theme: theme)

    experience
  }

  it_behaves_like 'a featurable entity'
end
