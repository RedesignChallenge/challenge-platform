# == Schema Information
#
# Table name: solutions
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  needs                   :text
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
#

require 'rails_helper'
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'

describe Solution do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:solution_story) }
  it { is_expected.to have_many(:steps) }
  it { is_expected.to have_and_belong_to_many(:experiences) }
  it { is_expected.to have_and_belong_to_many(:ideas) }
  it { is_expected.to have_and_belong_to_many(:approaches) }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
end