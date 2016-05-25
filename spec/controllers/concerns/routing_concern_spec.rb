require 'rails_helper'

class RoutingOrientedController < ApplicationController
end

describe RoutingOrientedController do

  let(:experience) {
    experience = FactoryGirl.create(:experience)
    theme = FactoryGirl.create(:theme)
    experience_stage = FactoryGirl.create(:experience_stage)
    challenge = FactoryGirl.create(:challenge)

    experience_stage.challenge = challenge
    theme.experience_stage = experience_stage
    experience.theme = theme
    experience
  }

  let(:idea) {
    idea = FactoryGirl.create(:idea)
    idea_stage = FactoryGirl.create(:idea_stage)
    problem_statement = FactoryGirl.create(:problem_statement)
    challenge = FactoryGirl.create(:challenge)

    idea_stage.challenge = challenge
    problem_statement.idea_stage = idea_stage
    idea.problem_statement = problem_statement
    idea
  }

  it 'returns the correct route for experiences if we pass in an experience' do
    result = subject.after_update_object_path_for(experience)

    expect(result).to eq "/challenges/#{experience.challenge.slug}/experience_stages/#{experience.experience_stage.id}/themes/#{experience.theme.id}/experiences/#{experience.id}"
  end

  context 'if the object is an idea' do
    it 'returns the correct route for ideas if we pass in an idea that is not destroyed' do
      result = subject.after_update_object_path_for(idea)

      expect(result).to eq "/challenges/#{idea.challenge.slug}/idea_stages/#{idea.idea_stage.id}/problem_statements/#{idea.problem_statement.id}/ideas/#{idea.id}"
    end

    it 'returns the correct route for ideas if we pass in an idea that is destroyed' do
      idea.destroy
      result = subject.after_update_object_path_for(idea)

      expect(result).to eq "/challenges/#{idea.challenge.slug}/idea_stages/#{idea.idea_stage.id}"
    end
  end

  context 'if the object is a comment' do

    let(:comment) { FactoryGirl.create(:comment) }

    it 'returns the correct route for experiences if we pass in an experience' do
      comment.commentable = experience
      result = subject.after_update_object_path_for(comment)

      expect(result).to eq "/challenges/#{experience.challenge.slug}/experience_stages/#{experience.experience_stage.id}/themes/#{experience.theme.id}/experiences/#{experience.id}"
    end

    it 'returns the correct route for ideas if we pass in an idea' do
      comment.commentable = idea
      result = subject.after_update_object_path_for(comment)

      expect(result).to eq "/challenges/#{idea.challenge.slug}/idea_stages/#{idea.idea_stage.id}/problem_statements/#{idea.problem_statement.id}/ideas/#{idea.id}"
    end

    it 'returns a query parameter indicating the parent comment ID if provided' do
      comment.commentable = experience
      result = subject.after_update_object_path_for(comment, temporal_parent_id: 2)

      expect(result).to eq "/challenges/#{experience.challenge.slug}/experience_stages/#{experience.experience_stage.id}/themes/#{experience.theme.id}/experiences/#{experience.id}?temporal_parent_id=2"
    end
  end

  it 'returns the root path if the object is not a comment, idea or experience' do
    a_string = 'This is a string!'
    result = subject.after_update_object_path_for(a_string)

    expect(result).to eq '/'
  end

  it 'returns the root path in case of an error' do
    result = subject.after_update_object_path_for(nil)
    
    expect(result).to eq '/'
  end

end