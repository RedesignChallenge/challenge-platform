# == Schema Information
#
# Table name: experiences
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  image                   :string
#  link                    :text
#  featured                :boolean
#  top_comment             :boolean
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
#

require 'rails_helper'
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'

describe Experience do

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:description).is_at_most(1024)}
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:theme) }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
end
