# == Schema Information
#
# Table name: approach_stages
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  active       :boolean
#  public       :boolean
#  starts_at    :datetime
#  ends_at      :datetime
#  challenge_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  incentive    :text
#

require 'rails_helper'

describe ApproachStage do
  it { is_expected.to belong_to(:challenge) }
  it { is_expected.to have_many(:approaches) }

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

  let(:first_approach_stage) {
    approach_stage = FactoryGirl.create(:approach_stage, challenge: first_challenge)
    approach_idea = FactoryGirl.create(:approach_idea, approach_stage: approach_stage)

    # Prime approach ideas as featured
    20.times do
      approach = FactoryGirl.create(:approach, approach_idea: approach_idea)
      approach_idea.approaches << approach
      FactoryGirl.create(:feature, featured: approach, active: true)
    end

    # Create 10 comments, with half of them featured.
    10.times do |n|
      comment = Comment.build_from(approach_idea, FactoryGirl.create(:user).id,
                                   { body: Faker::Lorem.sentence, link: Faker::Internet.url })
      comment.save!
      FactoryGirl.create(:feature, featured: comment, active: n % 2 == 0)
    end

    # Create 40 approaches which aren't active; half of them do not have a "feature" attached.
    40.times do |n|
      approach = FactoryGirl.create(:approach, approach_idea: approach_idea)
      approach_idea.approaches << approach
      if n >= 20
        FactoryGirl.create(:feature, featured: approach, active: false)
      end
    end
    approach_stage
  }

  let(:second_approach_stage) {
    approach_stage = FactoryGirl.create(:approach_stage, challenge: second_challenge)
    approach_idea = FactoryGirl.create(:approach_idea, approach_stage: approach_stage)

    # Prime approach ideas as featured
    45.times do
      approach = FactoryGirl.create(:approach, approach_idea: approach_idea)
      approach_idea.approaches << approach
      FactoryGirl.create(:feature, featured: approach, active: true)
    end

    # Create 30 comments, with a third of them featured.
    30.times do |n|
      comment = Comment.build_from(approach_idea, FactoryGirl.create(:user).id,
                                   { body: Faker::Lorem.sentence, link: Faker::Internet.url })
      comment.save!
      FactoryGirl.create(:feature, featured: comment, active: n % 3 == 0 )
    end

    # Create 12 approaches which aren't active; half of them do not have a "feature" attached.
    12.times do |n|
      approach = FactoryGirl.create(:approach, approach_idea: approach_idea)
      approach_idea.approaches << approach
      if n >= 6
        FactoryGirl.create(:feature, featured: approach, active: false)
      end
    end
    approach_stage
  }

  it 'returns all featured approaches bound to a specific challenge' do
    expect(first_approach_stage.featured_approaches.size).to eq 20
    expect(second_approach_stage.featured_approaches.size).to eq 45
  end

  it 'returns all featured comments bound to a specific challenge' do
    expect(first_approach_stage.featured_approach_comments.size).to eq 5
    expect(second_approach_stage.featured_approach_comments.size).to eq 10
  end
end
