require 'rails_helper'
require 'support/standard_controller_actions'

describe RecipesController do

  let(:second_fragment) {
    recipe_stage = FactoryGirl.create(:recipe_stage)
    challenge.recipe_stage = recipe_stage
    recipe_stage
  }

  let(:third_fragment) {
    cookbook = FactoryGirl.create(:cookbook)
    second_fragment.cookbooks << cookbook
    cookbook
  }

  let(:preexisting_entity) {
    recipe = FactoryGirl.create(:recipe, user: user, published_at: Time.now)
    third_fragment.recipes << recipe
    recipe
  }

  let(:unpublished_entity) {
    recipe = FactoryGirl.create(:recipe, user: user)
    third_fragment.recipes << recipe
    recipe
  }

  let(:redirect_path) {}

  let(:savable_entity) {
    {
      title: 'An awesome recipe',
      description: 'this is a pretty bland description',
      evidence: 'This is the evidence for how we know were winning',
      protips: 'Dont mess this up!',
      materials: 'Elbow grease, Red Bull, and faith',
      community: 'The community needs to be really supportive.',
      conditions: 'The conditions need to be really ripe.',
      link: 'http://www.google.com',
      steps_attributes: [
        {description: 'Drink the Red Bull.  Gain wings.'},
        {description: 'Roll up sleeves. This is going to get messy.'},
        {description: 'Put on a blindfold and start typing furiously away at the keyboard.  You will know when you are done.'}
      ],
      cookbook_id: third_fragment.id,
      published: 'true'
    }
  }

  let(:draft_entity) {
    {
      title: 'An awesome recipe',
      description: 'this is a pretty bland description',
      evidence: 'This is the evidence for how we know were winning',
      protips: 'Dont mess this up!',
      materials: 'Elbow grease, Red Bull, and faith',
      community: 'The community needs to be really supportive.',
      conditions: 'The conditions need to be really ripe.',
      link: 'http://www.google.com',
      steps_attributes: [
        {description: 'Drink the Red Bull.  Gain wings.'},
        {description: 'Roll up sleeves. This is going to get messy.'},
        {description: 'Put on a blindfold and start typing furiously away at the keyboard.  You will know when you are done.'}
      ],
      cookbook_id: third_fragment.id,
    }
  }

  let(:unsavable_entity) {
    {
      title: 'An awesome recipe',
      description: 'this is a pretty broken description',
      link: 'ftp://google.com'
    }
  }

  let(:valid_patch_model) {
    {
      description: 'This is a much, much better description!!',
      link: 'http://www.yahoo.com'
    }
  }

  let(:valid_patch_publish_model) {
    {
      description: 'This is a much, much better description!!',
      link: 'http://www.yahoo.com',
      published: 'true'
    }
  }

  let(:invalid_patch_model) {
    {
      description: 'This is a much, much better description!!',
      link: 'ftp://www.yahoo.com'
    }
  }

  include_examples 'a standard controller'

  describe 'POST #create' do
    before(:each) do
      sign_in user
    end

    it 'creates a new recipe without steps' do
      post :create, challenge_id: challenge.id,
           :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
           :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
           recipe: {
            title: 'An awesome recipe',
            description: 'This recipe will be awesome, and we want you to realize it!!',
            evidence: 'This is the evidence for how we know were winning',
            protips: 'Dont mess this up!',
            materials: 'Elbow grease, Red Bull, and faith',
            community: 'The community needs to be really supportive.',
            conditions: 'The conditions need to be really ripe.',
            link: 'http://www.google.com',
            cookbook_id: third_fragment.id
           }

      expect(third_fragment.recipes.size).to eq 1
      expect(assigns(:recipe).title).to eq 'An awesome recipe'
      expect(assigns(:recipe).description).to eq 'This recipe will be awesome, and we want you to realize it!!'
      expect(assigns(:recipe).evidence).to eq 'This is the evidence for how we know were winning'
      expect(assigns(:recipe).protips).to eq 'Dont mess this up!'
      expect(assigns(:recipe).materials).to eq 'Elbow grease, Red Bull, and faith'
      expect(assigns(:recipe).community).to eq 'The community needs to be really supportive.'
      expect(assigns(:recipe).conditions).to eq 'The conditions need to be really ripe.'
      expect(assigns(:recipe).link).to eq 'http://www.google.com'
    end

    it 'creates a new recipe with steps' do
      post :create, challenge_id: challenge.id,
        :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
        :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
        recipe: {
          title: 'An awesome recipe',
          description: 'This recipe will be awesome, and we want you to realize it!!',
          evidence: 'This is the evidence for how we know were winning',
          protips: 'Dont mess this up!',
          materials: 'Elbow grease, Red Bull, and faith',
          community: 'The community needs to be really supportive.',
          conditions: 'The conditions need to be really ripe.',
          link: 'http://www.google.com',
          cookbook_id: third_fragment.id,
          steps_attributes:
            [
              {description: 'Drink the Red Bull.  Gain wings.'},
              {description: 'Roll up sleeves. This is going to get messy.'},
              {description: 'Put on a blindfold and start typing furiously away at the keyboard.  You will know when you are done.'}
            ]
        }
      expect(assigns(:recipe).steps.size).to eq 3
    end
  end

  describe 'PUT #try' do

    context 'with an authenticated user' do
      before(:each) do
        sign_in user
      end

      it 'creates a vote on the entity' do
        put :try, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(assigns(target_model).get_upvotes(vote_scope: 'try').length).to eq 1
      end
    end

    context 'with an unauthenticated user' do
      before(:each) do
        sign_out user
      end

      it 'stores their like in the cache' do
        put :try, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(session[:like]).to_not be_nil
      end
    end
  end

  describe 'PUT #untry' do
    context 'with an authenticated user' do

      before(:each) do
        preexisting_entity.liked_by(user, vote_scope: 'try')
        sign_in user
      end

      it 'unupvotes the like on the entity' do
        put :untry, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(assigns(target_model).get_upvotes(vote_scope: 'try').size).to eq 0
      end

      it 'responds with JavaScript when calling via JavaScript' do
        put :untry, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id,
            format: :js
        expect(response).to render_template :untry
      end

      it 'redirects when calling via HTML' do
        put :untry, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(response).to redirect_to redirect_path || "/challenges/#{assigns(target_model).challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}/#{underscore_and_pluralize(third_fragment.class)}/#{third_fragment.id}/#{pluralize(target_model)}/#{assigns(target_model).id}"
      end
    end
  end

end