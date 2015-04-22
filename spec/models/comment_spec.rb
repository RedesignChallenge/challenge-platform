# == Schema Information
#
# Table name: comments
#
#  id                      :integer          not null, primary key
#  commentable_id          :integer
#  commentable_type        :string
#  body                    :text
#  user_id                 :integer          not null
#  parent_id               :integer
#  lft                     :integer
#  rgt                     :integer
#  reported                :boolean          default(FALSE), not null
#  created_at              :datetime
#  updated_at              :datetime
#  embed                   :text
#  link                    :text
#  temporal_parent_id      :integer
#  destroyed_at            :datetime
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
require 'models/concerns/feature_concern'

describe Comment do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:commentable) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to have_one :feature }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'

  context 'with comments that are soft deleted' do
    it 'does not pull back any comments' do
      user = FactoryGirl.create(:user, email: 'foo@bar.com')
      5.times do
        FactoryGirl.create(:comment, user: user)
      end
      deleted_comment = Comment.last
      deleted_comment.destroy

      expect(Comment.all.length).to eq 4
      expect(Comment.all).not_to include deleted_comment
    end
  end


  let(:entity) {
    comment = FactoryGirl.create(:comment)
    idea_stage = FactoryGirl.create(:idea_stage, challenge: challenge)
    problem_statement = FactoryGirl.create(:problem_statement, idea_stage: idea_stage)
    commentable_entity = FactoryGirl.create(:idea, problem_statement: problem_statement)

    comment.commentable = commentable_entity
    comment
  }

  it_behaves_like 'a featurable entity'
end
