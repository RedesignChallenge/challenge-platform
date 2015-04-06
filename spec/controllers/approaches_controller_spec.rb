require 'rails_helper'
require 'support/standard_controller_actions'

describe ApproachesController do

  let(:second_fragment) {
    approach_stage = FactoryGirl.create(:approach_stage)
    challenge.approach_stage = approach_stage
    approach_stage
  }

  let(:third_fragment) {
    approach_idea = FactoryGirl.create(:approach_idea)
    second_fragment.approach_ideas << approach_idea
    approach_idea
  }

  let(:preexisting_entity) {
    approach = FactoryGirl.create(:approach, user: user)
    third_fragment.approaches << approach
    approach
  }

  let(:redirect_path) {}

  let(:savable_entity) {
    {
      title: 'An awesome approach',
      description: 'this is a pretty bland description',
      needs: 'Elbow grease, Red Bull, and faith',
      link: 'http://www.google.com',
      steps_attributes: [
        {description: 'Drink the Red Bull.  Gain wings.'},
        {description: 'Roll up sleeves. This is going to get messy.'},
        {description: 'Put on a blindfold and start typing furiously away at the keyboard.  You will know when you are done.'}
      ],
      approach_idea_id: third_fragment.id
    }
  }

  let(:unsavable_entity) {
    {
      title: 'An awesome approach',
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

  let(:invalid_patch_model) {
    {
      description: 'This is a much, much better description!!',
      link: 'ftp://www.yahoo.com'
    }
  }

  include_examples 'a standard controller'

  describe 'POST #create' do

    let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
  
    let(:challenge) { FactoryGirl.create(:challenge) }

    let(:approach_stage) { 
      approach_stage = FactoryGirl.create(:approach_stage)
      challenge.approach_stage = approach_stage
      approach_stage
    }

    let(:approach_idea)  {
      approach_idea = FactoryGirl.create(:approach_idea)
      approach_stage.approach_ideas << approach_idea
      approach_idea
    }

    let(:approach) {
      approach = FactoryGirl.create(:approach, user: user)
      approach_idea.approaches << approach
      approach
    }

    before(:each) do
      sign_in user
    end

    it 'creates a new approach without steps' do
      post :create, challenge_id: challenge.id,
           approach_stage_id: approach_stage.id,
           approach_idea_id: approach_idea.id,
           approach: {
               title: 'An awesome approach',
               description: 'This approach will be awesome, and we want you to realize it!!',
               needs: 'Elbow grease, Red Bull, and faith',
               link: 'http://www.google.com',
               approach_idea_id: approach_idea.id
           }

      expect(approach_idea.approaches.size).to eq 1
      expect(assigns(:approach).title).to eq 'An awesome approach'
      expect(assigns(:approach).description).to eq 'This approach will be awesome, and we want you to realize it!!'
      expect(assigns(:approach).needs).to eq 'Elbow grease, Red Bull, and faith'
      expect(assigns(:approach).link).to eq 'http://www.google.com'
    end

    it 'creates a new approach with steps' do
      post :create, challenge_id: challenge.id,
        approach_stage_id: approach_stage.id,
        approach_idea_id: approach_idea.id,
        approach: {
          title: 'An awesome approach',
          description: 'This approach will be awesome, and we want you to realize it!!',
          needs: 'Elbow grease, Red Bull, and faith',
          link: 'http://www.google.com',
          approach_idea_id: approach_idea.id,
          steps_attributes:
            [
              {description: 'Drink the Red Bull.  Gain wings.'},
              {description: 'Roll up sleeves. This is going to get messy.'},
              {description: 'Put on a blindfold and start typing furiously away at the keyboard.  You will know when you are done.'}
            ]
        }
      expect(assigns(:approach).steps.size).to eq 3
    end
  end
end