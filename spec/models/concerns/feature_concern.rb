require 'rails_helper'

shared_examples_for 'a featurable entity' do

  let(:non_panelist) {
    FactoryGirl.create(:user)
  }

  let(:panelists) {
    panelists = Array.new
    3.times do
      panelists.push(FactoryGirl.create(:user))
    end
    panelists
  }

  let(:challenge) {
    FactoryGirl.create(:challenge, :with_panelists, panelists: panelists)
  }

  let(:feature) {
    FactoryGirl.create(:feature)
  }


  it 'marks an entity with a non-panelist as invalid' do
    feature.featured = entity
    feature.user = non_panelist
    expect(feature.valid?).to eq false
  end

  it 'marks an entity with a panelist as valid' do
    feature.featured = entity
    feature.user = panelists.first
    expect(feature.valid?).to eq true
  end

  it 'marks an entity without a user as valid' do
    feature.featured = entity
    expect(feature.valid?).to eq true
  end
end