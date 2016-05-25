# == Schema Information
#
# Table name: suggestions
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  link                    :text
#  embed                   :text
#  image                   :string
#  destroyed_at            :datetime
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

describe Suggestion do

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }  
  # it { is_expected.to validate_length_of(:description).is_at_most(1024)}
  it { is_expected.to belong_to(:user) }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
end
