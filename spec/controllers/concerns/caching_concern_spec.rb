require 'rails_helper'

class CacheOrientedController < ApplicationController
end

describe CacheOrientedController do

  context 'when storing a like into the session' do

    let(:idea) { FactoryGirl.create(:idea) }

    it 'writes a single like into the like session' do
      scope = 'Test Scope'
      expected = {likeable_type: 'Idea', likeable_id: idea.id, vote_scope: scope}

      subject.cache_pending_like(idea, {vote_scope: scope})
      expect(session[:like]).to eq expected
    end

    it 'updates an existing vote if only the scope has changed' do
      scope = 'Test Scope'
      new_scope = 'Test Scope Prime'

      subject.cache_pending_like(idea, {vote_scope: scope})
      subject.cache_pending_like(idea, {vote_scope: new_scope})

      expect(session[:like][:vote_scope]).to eq new_scope
    end

    it 'stores only the last like into the session' do
      experience = FactoryGirl.create(:experience)
      scope = 'Test Scope'

      expected = {likeable_type: 'Experience', likeable_id: experience.id, vote_scope: scope}

      subject.cache_pending_like(idea, {vote_scope: scope})
      subject.cache_pending_like(experience, {vote_scope: scope})

      expect(session[:like]).to eq expected
    end

    it 'stores nothing if no likeable_id is supplied' do
      experience = FactoryGirl.build(:experience)
      scope = 'Test Scope'

      subject.cache_pending_like(experience, {vote_scope: scope})

      expect(session[:like]).to be_nil
    end
  end

  context 'when storing an entity into the session' do
    it 'stores an entity into the session' do
      experience = FactoryGirl.create(:experience)
      subject.cache_pending_object(experience)

      expect(session[:object]).to eq experience
    end

    it 'only allows one entity to remain in the session' do
      entities = [FactoryGirl.create(:experience), FactoryGirl.create(:idea), FactoryGirl.create(:comment)].shuffle!

      entities.each { |entity|
        subject.cache_pending_object(entity)
      }

      expect(session[:object]).to eq entities.last
    end
  end

  context 'when storing both a like and an entity' do

    let(:entity) { FactoryGirl.create(:experience) }

    it 'only stores a like if an entity previously existed' do
      subject.cache_pending_object(entity)

      subject.cache_pending_like(entity, {vote_scope: 'test'})

      expect(session[:object]).to be_nil
      expect(session[:like]).to_not be_nil
    end

    it 'only stores an entity if a like previously existed' do
      subject.cache_pending_like(entity, {vote_scope: 'test'})
      subject.cache_pending_object(entity)

      expect(session[:like]).to be_nil
      expect(session[:object]).to_not be_nil
    end
  end
end
