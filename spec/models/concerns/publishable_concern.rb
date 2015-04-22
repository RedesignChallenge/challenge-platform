require 'rails_helper'
require 'faker'

shared_examples_for 'a publishable entity' do

  context 'when the user is defined' do

    context 'when the user does not own the entities that are unpublished' do

      let(:other_user) { FactoryGirl.create(:user) }

      let(:user) { FactoryGirl.create(:user) }

      let!(:unpublished_entities) {
        FactoryGirl.create_list(described_class.to_s.downcase, 5, user: user)
      }

      let!(:published_entities) {
        FactoryGirl.create_list(described_class.to_s.downcase, 15, user: other_user, published_at: Time.now)
      }


      it 'retrieves only non-draft entities' do
        result = described_class.published(other_user).all
        expect(result.size).to eq 15
      end
    end

    context 'when the user owns the entities that are unpublished' do

      let(:other_user) { FactoryGirl.create(:user, email: Faker::Internet.email) }

      let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }

      let!(:unpublished_entities) {
        FactoryGirl.create_list(described_class.to_s.downcase, 5, user: user)
      }

      let!(:published_entities) {
        FactoryGirl.create_list(described_class.to_s.downcase, 15, user: other_user, published_at: Time.now)
      }

      it 'retrieves all entities' do
        result = described_class.published(user).all
        expect(result.size).to eq 20
      end
    end
  end

  context 'when the user is not defined' do

    let!(:unpublished_entities) {
      FactoryGirl.create_list(described_class.to_s.downcase, 5, user: FactoryGirl.create(:user))
    }

    let!(:published_entities) {
      FactoryGirl.create_list(described_class.to_s.downcase, 15, user: FactoryGirl.create(:user), published_at: Time.now)
    }

    context 'with no user supplied' do

      let(:user) { nil }

      it 'retrieves only non-draft entities' do
        result = described_class.published(user).all
        expect(result.size).to eq 15
      end
    end

    context 'with an unpersisted user' do

      let(:user) { FactoryGirl.build(:user) }

      it 'retrieves only non-draft entities' do
        result = described_class.published(user).all
        expect(result.size).to eq 15
      end
    end
  end
end