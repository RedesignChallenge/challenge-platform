# == Schema Information
#
# Table name: ideas
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  link                    :text
#  image                   :string
#  file                    :string
#  embed                   :text
#  problem_statement_id    :integer
#  user_id                 :integer
#  refinement_parent_id    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  destroyed_at            :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  impact                  :text
#  implementation          :text
#

require 'rails_helper'
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'

describe Idea do

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:description).is_at_most(1024)}
  it { is_expected.to validate_length_of(:impact).is_at_most(1024)}
  it { is_expected.to validate_length_of(:implementation).is_at_most(1024)}

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:problem_statement) }
  it { is_expected.to belong_to(:refinement_parent).class_name('Idea') }
  it { is_expected.to have_many(:refinements).class_name('Idea').with_foreign_key('refinement_parent_id') }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
end
