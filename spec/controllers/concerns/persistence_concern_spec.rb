require 'rails_helper'

class PersistenceOrientedConcern < ApplicationController
end

describe PersistenceOrientedConcern do

  let(:user) { FactoryGirl.create(:user, email: 'the-user@overload.net')}
  let(:experience) { experience = FactoryGirl.create(:experience) }
  let(:idea) { FactoryGirl.create(:idea, user: FactoryGirl.create(:user, email: Faker::Internet.email)) }

  before(:each) do
    sign_in user
  end

  context 'when persisting likes' do

    it 'persists nothing if the session contains none to persist' do
      subject.persist_pending_cache

      expect(user.votes.up.size).to eq 0
    end

    it 'persists the last like associated with the appropriate likeable entity' do

      entities_and_scopes = [
          {entity: experience, vote_scope: 'like'},
          {entity: idea, vote_scope: 'like'}
      ].shuffle!

      entities_and_scopes.each { |pair|
        subject.cache_pending_like(pair[:entity], {vote_scope: pair[:vote_scope]})
      }

      subject.persist_pending_cache

      expect(user.votes.up.size).to eq 1
    end

    it 'updates the flash message appropriately' do
      subject.cache_pending_like(idea, {vote_scope: 'sample scope'})
      subject.persist_pending_cache

      expect(flash[:success]).to eq "You've successfully liked this idea."
    end

    it 'redirects you to the appropriate location after liking the entity' do
      # Because this experience doesn't have the challenge or experience stage set up,
      # it will redirect you to the root path.
      # The actual result of routing in after_update_object_path is covered
      # in the routing_concern_spec.
      subject.cache_pending_like(experience, {vote_scope: 'sample scope'})
      subject.persist_pending_cache

      expect(session[:user_return_to]).to eq "/"
    end

    it 'clears the cache after persistence' do
      experience = FactoryGirl.create(:experience, user: FactoryGirl.create(:user, email: Faker::Internet.email))
      idea = FactoryGirl.create(:idea, user: FactoryGirl.create(:user, email: Faker::Internet.email))

      entities_and_scopes = [
          {entity: experience, vote_scope: 'sample scope'},
          {entity: idea, vote_scope: 'sample scope'}
      ].shuffle!

      entities_and_scopes.each { |pair|
        subject.cache_pending_like(pair[:entity], {vote_scope: pair[:vote_scope]})
      }

      subject.persist_pending_cache

      expect(session[:likes]).to be_nil
    end
  end

  context 'when persisting entities' do
    it 'actually persists the entity' do
      experience = FactoryGirl.create(:experience)
      subject.cache_pending_object(experience)

      subject.persist_pending_cache

      expect(experience.user).to eq user
    end

    it 'sets the flash message appropriately' do
      experience = FactoryGirl.create(:experience)
      subject.cache_pending_object(experience)

      subject.persist_pending_cache

      expect(flash[:success]).to eq "You've successfully shared your experience."
    end

    it "sets the entity's return path correctly" do
      experience = FactoryGirl.create(:experience)
      challenge = FactoryGirl.create(:challenge)
      experience_stage = FactoryGirl.create(:experience_stage)
      theme = FactoryGirl.create(:theme)

      experience_stage.challenge = challenge

      experience.theme = theme
      experience_stage.themes << theme

      subject.cache_pending_object(experience)

      subject.persist_pending_cache
      
      expect(session[:user_return_to]).to eq "/challenges/#{challenge.slug}/experience_stages/#{experience_stage.id}/themes/#{theme.id}/experiences/#{experience.id}"
    end

    it 'removes the entity from the cache' do
      experience = FactoryGirl.create(:experience)
      subject.cache_pending_object(experience)

      subject.persist_pending_cache

      expect(session[:object]).to be_nil
    end
  end
end