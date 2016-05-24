# == Schema Information
#
# Table name: recipe_stages
#
#  id                       :integer          not null, primary key
#  title                    :string
#  description              :text
#  active                   :boolean
#  public                   :boolean
#  starts_at                :datetime
#  ends_at                  :datetime
#  challenge_id             :integer
#  created_at               :datetime
#  updated_at               :datetime
#  incentive                :text
#  title_instructions       :text             default("Add a Title")
#  description_instructions :text             default("Describe your recipe. What are the goals? What are the challenges? Why does this recipe matter?")
#  steps_instructions       :text             default("Outline how to implement this recipe step by step.")
#  materials_instructions   :text             default("What equipment or supplies are needed?")
#  community_instructions   :text             default("Every good recipe provides the number of servings. How many people need to participate and who are they?")
#  conditions_instructions  :text             default("What needs to be true of the culture or environment to try out this recipe?")
#  evidence_instructions    :text             default("What evidence can we collect to know when we’re on the right track?")
#  protips_instructions     :text             default("What advice can you offer to make the experience of trying out your recipe as smooth as possible?  Is there anything you can identify as a possible stumbling block? Things to keep in mind?")
#

require 'rails_helper'

describe RecipeStage do
  it { is_expected.to belong_to(:challenge) }
  it { is_expected.to have_many(:recipes) }

  let(:panelists) {
    panelists = Array.new
    3.times do
      panelists.push(FactoryGirl.create(:user))
    end
    panelists
  }

  let(:first_challenge) {
    FactoryGirl.create(:challenge, :with_panelists, panelists: panelists)
  }

  let(:second_challenge) {
    FactoryGirl.create(:challenge, :with_panelists, panelists: panelists)
  }

  let(:first_recipe_stage) {
    recipe_stage = FactoryGirl.create(:recipe_stage, challenge: first_challenge)
    cookbook = FactoryGirl.create(:cookbook, recipe_stage: recipe_stage)

    # Prime recipe ideas as featured
    20.times do
      recipe = FactoryGirl.create(:recipe, cookbook: cookbook)
      cookbook.recipes << recipe
      FactoryGirl.create(:feature, featureable: recipe, active: true, challenge: first_challenge)
    end

    # Create 10 comments, with half of them featured.
    10.times do |n|
      comment = Comment.build_from(cookbook, FactoryGirl.create(:user).id,
                                   { body: Faker::Lorem.sentence, link: Faker::Internet.url })
      comment.save!
      FactoryGirl.create(:feature, featureable: comment, active: n % 2 == 0, challenge: first_challenge)
    end

    # Create 40 recipes which aren't active; half of them do not have a "feature" attached.
    40.times do |n|
      recipe = FactoryGirl.create(:recipe, cookbook: cookbook)
      cookbook.recipes << recipe
      if n >= 20
        FactoryGirl.create(:feature, featureable: recipe, challenge: first_challenge, active: false)
      end
    end
    recipe_stage
  }

  let(:second_recipe_stage) {
    recipe_stage = FactoryGirl.create(:recipe_stage, challenge: second_challenge)
    cookbook = FactoryGirl.create(:cookbook, recipe_stage: recipe_stage)

    # Prime recipe ideas as featured
    45.times do
      recipe = FactoryGirl.create(:recipe, cookbook: cookbook)
      cookbook.recipes << recipe
      FactoryGirl.create(:feature, featureable: recipe, challenge: second_challenge, active: true)
    end

    # Create 30 comments, with a third of them featured.
    30.times do |n|
      comment = Comment.build_from(cookbook, FactoryGirl.create(:user).id,
                                   { body: Faker::Lorem.sentence, link: Faker::Internet.url })
      comment.save!
      FactoryGirl.create(:feature, featureable: comment, challenge: second_challenge, active: n % 3 == 0 )
    end

    # Create 12 recipes which aren't active; half of them do not have a "feature" attached.
    12.times do |n|
      recipe = FactoryGirl.create(:recipe, cookbook: cookbook)
      cookbook.recipes << recipe
      if n >= 6
        FactoryGirl.create(:feature, featureable: recipe, challenge: second_challenge, active: false)
      end
    end
    recipe_stage
  }

  it 'returns all featured recipes bound to a specific challenge' do
    expect(first_recipe_stage.recipes.where(featured: true).size).to eq 20
    expect(second_recipe_stage.recipes.where(featured: true).size).to eq 45
  end

  # it 'returns all featured comments bound to a specific challenge' do
  #   expect(first_recipe_stage.featured_recipe_comments.size).to eq 5
  #   expect(second_recipe_stage.featured_recipe_comments.size).to eq 10
  # end
end
