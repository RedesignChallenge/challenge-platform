require 'rails_helper'

shared_examples_for 'an entity respecting the default order' do
  let(:model) { described_class }

  context 'when there is no tie on an entities'' votes' do

    let!(:models) {
      3.times do |n|
        entity = FactoryGirl.create(described_class.to_s.downcase.to_sym)
        vote_for_entity(n + 1, entity)
      end
    }

    it 'lists the one with 3 votes first' do
      result = described_class.all
      expect(result.first.votes_for.size).to eq 3

    end

    it 'lists the one with 1 vote third' do
      result = described_class.all
      expect(result.third.votes_for.size).to eq 1
    end
  end

  context 'when there is a tie on an entities'' votes' do


    let!(:models) {
      3.times do |n|
        entity = FactoryGirl.create(described_class.to_s.downcase.to_sym)
        vote_for_entity(3, entity)
        comment_on_entity(n + 1, entity)
      end
    }


    it 'lists the one with 3 comments first' do
      result = described_class.all
      expect(result.first.comments_count).to eq 3
    end

    it 'lists the one with 1 comment third' do
      result = described_class.all
      expect(result.third.comments_count).to eq 1
    end
  end

  context 'when there is a tie on an entities'' votes and comments count' do

    let(:now) {
      Time.now.getlocal('+00:00')
    }

    let!(:models) {
      3.times do |n|
        entity = FactoryGirl.create(described_class.to_s.downcase.to_sym, created_at: now.days_ago(n+1).getlocal('+00:00'))
        vote_for_entity(3, entity)
        comment_on_entity(3, entity)
      end
    }


    it 'lists the one created 3 days ago third' do
      result = described_class.all
      expect(result.third.created_at).to be_within(1.second).of now.days_ago(3)

    end

    it 'lists the one created 1 day ago first' do
      result = described_class.all
      expect(result.first.created_at).to be_within(1.second).of now.days_ago(1)
    end
  end

  context 'when there is a tie on an entities'' votes, comments count and creation date' do

    let(:now) {
      Time.now
    }

    let!(:models) {
      3.times do
        entity = FactoryGirl.create(described_class.to_s.downcase.to_sym, created_at: now)
        vote_for_entity(3, entity)
        comment_on_entity(3, entity)
      end
    }

    let!(:max_id_entity) {
      described_class.find(described_class.maximum(:id))
    }

    let!(:min_id_entity) {
      described_class.find(described_class.minimum(:id))
    }

    it 'lists the one with the highest id first' do
      expect(described_class.all.first).to eq max_id_entity
    end

    it 'lists the one with the lowest id last' do
      expect(described_class.all.last).to eq min_id_entity
    end
  end
end


private

def vote_for_entity(n, entity)
  n.times do
    entity.liked_by(FactoryGirl.create(:user), vote_scope: entity.default_like[:scope])
  end
end

def comment_on_entity(n, entity)
  n.times do
    comment = Comment.build_from(entity, FactoryGirl.create(:user).id, {body: "Test comment"})
    comment.save!
  end
  entity.save!
end