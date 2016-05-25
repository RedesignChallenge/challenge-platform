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
#  featured                :boolean          default(FALSE)
#

require 'rails_helper'
require 'models/concerns/embeddable_concern'
require 'models/concerns/url_normalizer_concern'
require 'models/concerns/feature_concern'
require 'sidekiq/testing'

describe Comment do

  let(:entity) {
    comment = FactoryGirl.create(:comment)
    idea_stage = FactoryGirl.create(:idea_stage, challenge: challenge)
    problem_statement = FactoryGirl.create(:problem_statement, idea_stage: idea_stage)
    commentable_entity = FactoryGirl.create(:idea, problem_statement: problem_statement)

    comment.commentable = commentable_entity
    comment
  }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:commentable) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to have_one :feature }

  it_behaves_like 'embeddable'
  it_behaves_like 'normalizable'
  it_behaves_like 'a featurable entity'

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

  context 'when looking at sibling comments' do

    let(:commentable) {
      experience = FactoryGirl.create(:experience)
      10.times do |i|
        FactoryGirl.create(:comment, commentable: experience, body: i.to_s)
      end

      experience
    }

    let(:comment) {
      commentable.comment_threads.first
    }

    it 'queries for sibling comments' do
      expect(comment.sibling_comments.size).to eq 9
    end

    it 'does not contain the calling comment\'s id' do
      expect(comment.sibling_comments.map(&:id).include? comment.id).to be false
    end
  end

  describe '#send_notifications' do
    context 'with users in the comment_replied notification group' do
      let(:commentable) {
        experience = FactoryGirl.create(:experience)
        10.times do |i|
          FactoryGirl.create(:comment, commentable: experience, body: i.to_s, user: FactoryGirl.create(:user, notifications: {:comment_replied => true, :comment_posted => false, :comment_followed => false}))
        end
        experience
      }

      let(:comment) {
        commentable.comment_threads.first
      }

      it 'queues nothing' do
        comment.send_notifications
        expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 0
      end
    end

    context 'with users in the comment_posted notification group' do
      let(:commentable) {
        experience = FactoryGirl.create(:experience)
        10.times do |i|
          FactoryGirl.create(:comment, commentable: experience, body: i.to_s, user: FactoryGirl.create(:user, notifications: {:comment_replied => false, :comment_posted => true, :comment_followed => false}))
        end
        experience
      }

      let(:comment) {
        commentable.comment_threads.first
      }

      it 'queues nothing' do
        comment.send_notifications
        expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 0
      end
    end

    context 'with users in both comment_posted and comment_replied notification groups' do
      let(:commentable) {
        experience = FactoryGirl.create(:experience)
        10.times do |i|
          FactoryGirl.create(:comment, commentable: experience, body: i.to_s, user: FactoryGirl.create(:user, notifications: {:comment_replied => true, :comment_posted => true, :comment_followed => false}))
        end
        experience
      }

      let(:comment) {
        commentable.comment_threads.first
      }

      it 'queues nothing' do
        comment.send_notifications
        expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 0
      end
    end

    context 'with users opting out of the comment_followed group' do
      let(:commentable) {
        experience = FactoryGirl.create(:experience)
        10.times do |i|
          FactoryGirl.create(:comment, commentable: experience, body: i.to_s, user: FactoryGirl.create(:user, notifications: {:comment_replied => false, :comment_posted => false, :comment_followed => false}))
        end
        experience
      }

      let(:comment) {
        commentable.comment_threads.first
      }

      it 'queues nothing' do
        comment.send_notifications
        expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 0
      end
    end
    
    context 'with users opted in' do
      let(:commentable) {
        experience = FactoryGirl.create(:experience)
        10.times do |i|
          FactoryGirl.create(:comment, commentable: experience, body: i.to_s, user: FactoryGirl.create(:user, notifications: {:comment_replied => false, :comment_posted => false, :comment_followed => true}))
        end
        experience
      }

      let(:comment) {
        commentable.comment_threads.first
      }

      it 'queues nine delayed mailer jobs' do
        comment.send_notifications
        expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 9
      end
    end
  end
end
