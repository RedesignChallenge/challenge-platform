require 'rails_helper'
require 'support/standard_controller_actions'

describe IdeasController do

  let(:second_fragment) {
    idea_stage = FactoryGirl.create(:idea_stage)
    challenge.idea_stage = idea_stage
    idea_stage
  }

  let(:third_fragment) {
    problem_statement = FactoryGirl.create(:problem_statement)
    second_fragment.problem_statements << problem_statement
    problem_statement
  }

  let(:preexisting_entity) {
    idea = FactoryGirl.create(:idea, user: user)
    third_fragment.ideas << idea
    idea
  }

  let(:redirect_path) {}

  let(:savable_entity) {
    {
      title: "A generic title", 
      description: "this is a pretty bland description", 
      problem_statement_id: third_fragment.id
    }
  }

  let(:unsavable_entity) {
    {
      title: "A generic title", 
      description: "this is a pretty broken description", 
      problem_statement_id: third_fragment.id, 
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
      link: 'obex://www.yahoo.com'
    }
  }

  include_examples 'a standard controller'
end