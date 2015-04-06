require 'rails_helper'
require 'support/standard_controller_actions'

describe ExperiencesController do

  let(:second_fragment) {
    experience_stage = FactoryGirl.create(:experience_stage)
    challenge.experience_stage = experience_stage
    experience_stage
  }

  let(:third_fragment) {
    theme = FactoryGirl.create(:theme)
    second_fragment.themes << theme
    theme
  }

  let(:preexisting_entity) {
    experience = FactoryGirl.create(:experience, user: user)
    third_fragment.experiences << experience
    experience
  }

  let(:redirect_path) {}

  let(:savable_entity) {
    {
      description: "this is a pretty bland description", 
      theme_id: third_fragment.id
    }
  }

  let(:unsavable_entity) {
    {
      description: "this is a pretty bad entity", 
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
      link: 'sftp://www.yahoo.com'
    }
  }

  include_examples 'a standard controller'
end