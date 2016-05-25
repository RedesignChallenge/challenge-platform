# == Schema Information
#
# Table name: challenges
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  hashtag      :string
#  slug         :string
#  video_url    :string
#  ends_at      :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  background   :text
#  outcome      :text
#  help         :text
#  image        :string
#  starts_at    :datetime
#  active_stage :string
#  headline     :string
#  incentive    :text
#  cta          :string
#  banner       :string
#  featured     :boolean
#

require 'rails_helper'

describe Challenge do

  it { is_expected.to have_one(:panel) }
  it { is_expected.to have_one(:experience_stage) }
  it { is_expected.to have_one(:idea_stage) }
  it { is_expected.to have_one(:recipe_stage) }
  it { is_expected.to have_one(:solution_stage) }


  context 'when displaying featured contributions for a particular stage' do

    let(:challenge) {
      FactoryGirl.create(:challenge)
    }

    let(:experience_stage) {
      theme = FactoryGirl.create(:theme)
      experience_stage = FactoryGirl.create(:experience_stage)
      15.times do |n|
        experience = FactoryGirl.create(:experience, published_at: Time.now)
        theme.experiences << experience
        FactoryGirl.create(:feature, featureable: experience, challenge: challenge, active: n < 3)
      end

      experience_stage.themes << theme
      experience_stage
    }

    let(:idea_stage) {
      problem_statement = FactoryGirl.create(:problem_statement)
      idea_stage = FactoryGirl.create(:idea_stage)
      15.times do |n|
        idea = FactoryGirl.create(:idea, published_at: Time.now)
        problem_statement.ideas << idea
        FactoryGirl.create(:feature, featureable: idea, challenge: challenge, active: n < 3)
      end

      idea_stage.problem_statements << problem_statement
      idea_stage
    }

    let(:recipe_stage) {
      cookbook = FactoryGirl.create(:cookbook)
      recipe_stage = FactoryGirl.create(:recipe_stage)
      15.times do |n|
        recipe = FactoryGirl.create(:recipe, published_at: Time.now)
        cookbook.recipes << recipe
        FactoryGirl.create(:feature, featureable: recipe, challenge: challenge, active: n < 3)
      end

      recipe_stage.cookbooks << cookbook
      recipe_stage
    }

    let(:solution_stage) {
      solution_stage = FactoryGirl.create(:solution_stage)
      15.times do |n|
        solution = FactoryGirl.create(:solution, published_at: Time.now)
        solution_story = FactoryGirl.create(:solution_story, solution: solution)
        FactoryGirl.create(:feature, featureable: solution, challenge: challenge, active: n < 3)
        solution_stage.solution_stories << solution_story
      end

      solution_stage
    }

    before(:each) do
      challenge.experience_stage = experience_stage
      challenge.idea_stage = idea_stage
      challenge.recipe_stage = recipe_stage
      challenge.solution_stage = solution_stage
    end

    it 'shows the top two featured experiences' do
      challenge.active_stage = 'experience'
      result = challenge.featured_contributions
      expect(result.size).to eq 2
      expect(result.first.feature.active).to eq true
      expect(result.last.feature.active).to eq true
      expect(result.to_ary.map(&:class).all? { |cls| cls == Experience }).to eq true
    end

    it 'shows the top three featured ideas' do
      challenge.active_stage = 'idea'
      result = challenge.featured_contributions
      expect(result.size).to eq 3
      expect(result.first.feature.active).to be true
      expect(result.second.feature.active).to be true
      expect(result.last.feature.active).to be true
      expect(result.to_ary.map(&:class).all? { |cls| cls == Idea }).to eq true
    end

    it 'shows the top two featured recipes' do
      challenge.active_stage = 'recipe'
      result = challenge.featured_contributions
      expect(result.size).to eq 2
      expect(result.first.feature.active).to eq true
      expect(result.last.feature.active).to eq true
      expect(result.to_ary.map(&:class).all? { |cls| cls == Recipe }).to eq true
    end

    it 'shows the top two featured solutions' do
      challenge.active_stage = 'solution'
      result = challenge.featured_contributions
      expect(result.size).to eq 2
      expect(result.first.feature.active).to eq true
      expect(result.last.feature.active).to eq true
      expect(result.to_ary.map(&:class).all? { |cls| cls == Solution }).to eq true
    end

    it 'returns nothing for a bogus stage' do
      challenge.active_stage = 'bogus'
      result = challenge.featured_contributions
      expect(result).to be_nil
    end
  end

  describe '#has_featured_for' do

    let(:first_challenge) {
      FactoryGirl.create(:challenge)
    }

    let(:second_challenge) {
      FactoryGirl.create(:challenge)
    }

    let(:experience_stage) {
      theme = FactoryGirl.create(:theme)
      experience_stage = FactoryGirl.create(:experience_stage)
      15.times do |n|
        experience = FactoryGirl.create(:experience, published_at: Time.now)
        theme.experiences << experience
        FactoryGirl.create(:feature, featureable: experience, challenge: first_challenge, active: n < 3)
      end

      experience_stage.themes << theme
      experience_stage
    }

    let(:idea_stage) {
      problem_statement = FactoryGirl.create(:problem_statement)
      idea_stage = FactoryGirl.create(:idea_stage)
      15.times do |n|
        idea = FactoryGirl.create(:idea, published_at: Time.now)
        problem_statement.ideas << idea
        FactoryGirl.create(:feature, featureable: idea, challenge: first_challenge, active: n < 3)
      end

      idea_stage.problem_statements << problem_statement
      idea_stage
    }

    let(:recipe_stage) {
      cookbook = FactoryGirl.create(:cookbook)
      recipe_stage = FactoryGirl.create(:recipe_stage)
      15.times do |n|
        recipe = FactoryGirl.create(:recipe, published_at: Time.now)
        cookbook.recipes << recipe
        FactoryGirl.create(:feature, featureable: recipe, challenge: first_challenge, active: n < 3)
      end

      recipe_stage.cookbooks << cookbook
      recipe_stage
    }

    let(:solution_stage) {
      solution_stage = FactoryGirl.create(:solution_stage)
      15.times do |n|
        solution = FactoryGirl.create(:solution, published_at: Time.now)
        solution_story = FactoryGirl.create(:solution_story, solution: solution)
        FactoryGirl.create(:feature, featureable: solution, challenge: first_challenge, active: n < 3)
        solution_stage.solution_stories << solution_story
      end

      solution_stage
    }

    before(:each) do
      first_challenge.experience_stage = experience_stage
      first_challenge.idea_stage = idea_stage
      first_challenge.recipe_stage = recipe_stage
      first_challenge.solution_stage = solution_stage
    end

    context 'with a challenge that has featured entities' do
      it 'returns true for Experiences' do
        expect(first_challenge.has_featured_for('Experience')).to be true
      end

      it 'returns true for Ideas' do
        expect(first_challenge.has_featured_for('Idea')).to be true
      end

      it 'returns true for Recipes' do
        expect(first_challenge.has_featured_for('Recipe')).to be true
      end

      it 'returns true for Solutions' do
        expect(first_challenge.has_featured_for('Solution')).to be true
      end
    end

    context 'with a challenge that has no featured entities' do
      it 'returns false for Experiences' do
        expect(second_challenge.has_featured_for('Experience')).to be false
      end

      it 'returns false for Ideas' do
        expect(second_challenge.has_featured_for('Idea')).to be false
      end

      it 'returns false for Recipes' do
        expect(second_challenge.has_featured_for('Recipe')).to be false
      end

      it 'returns false for Solutions' do
        expect(second_challenge.has_featured_for('Solution')).to be false
      end
    end
  end
end
