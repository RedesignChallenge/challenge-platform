# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  role                   :string
#  organization           :string
#  admin                  :boolean          default(FALSE)
#  ga_dimension           :string
#  title                  :string
#  video_access           :boolean          default(FALSE)
#  twitter                :string
#  avatar                 :string
#  future_participant     :boolean          default(TRUE)
#  color                  :string
#  bio                    :text
#  referrer_id            :integer
#  display_name           :string
#  avatar_option          :string           default("twitter")
#  notifications          :hstore           default({"comment_posted"=>"true", "comment_replied"=>"true"})
#

require 'rails_helper'

describe User do

  it { is_expected.to have_and_belong_to_many(:states) }
  it { is_expected.to have_and_belong_to_many(:districts) }
  it { is_expected.to have_and_belong_to_many(:schools) }
  it { is_expected.to have_and_belong_to_many(:panels) }
  it { is_expected.to have_many(:experiences) }
  it { is_expected.to have_many(:ideas) }
  it { is_expected.to have_many(:approaches) }
  it { is_expected.to have_many(:solutions) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to belong_to(:referrer).class_name('User').with_foreign_key(:referrer_id)}
  it { is_expected.to have_many(:referrals).class_name('User').with_foreign_key(:referrer_id)}

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(255) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(255) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_length_of(:role).is_at_most(255) }

  it { is_expected.to validate_length_of(:organization).is_at_most(255) }
  it { is_expected.to validate_length_of(:title).is_at_most(255) }
  it { is_expected.to validate_length_of(:twitter).is_at_most(16) }
  it { is_expected.to validate_length_of(:bio).is_at_most(2047) }

  describe '#has_draft_submissions?' do
    context 'with an entity that is unpublished' do
      let(:user) {
        FactoryGirl.create(:user)
      }

      let(:experience) {
        FactoryGirl.create_list(:experience, 1) + FactoryGirl.create_list(:experience, 5, published_at: Time.now)
      }

      let(:idea) {
        FactoryGirl.create_list(:idea, 1) + FactoryGirl.create_list(:idea, 5, published_at: Time.now)
      }

      let(:approach) {
        FactoryGirl.create_list(:approach, 1) + FactoryGirl.create_list(:approach, 5, published_at: Time.now)
      }

      let(:solution) {
        FactoryGirl.create_list(:solution, 1) + FactoryGirl.create_list(:solution, 5, published_at: Time.now)
      }

      it 'returns true for an experience' do
        user.experiences << experience
        expect(user.has_draft_submissions?).to eq true
      end

      it 'returns true for an idea' do
        user.ideas << idea
        expect(user.has_draft_submissions?).to eq true
      end

      it 'returns true for an approach' do
        user.approaches << approach
        expect(user.has_draft_submissions?).to eq true
      end

      it 'returns true for a solution' do
        user.solutions << solution
        expect(user.has_draft_submissions?).to eq true
      end

      it 'returns true with an experience, idea, approach, and solution unpublished' do
        user.experiences << experience
        user.ideas << idea
        user.approaches << approach
        user.solutions << solution
        expect(user.has_draft_submissions?).to eq true
      end
    end

    context 'with no entities that are unpublished' do
      let(:user) {
        FactoryGirl.create(:user)
      }

      let(:experience) {
        FactoryGirl.create_list(:experience, 5, published_at: Time.now)
      }

      let(:idea) {
        FactoryGirl.create_list(:idea, 5, published_at: Time.now)
      }

      let(:approach) {
        FactoryGirl.create_list(:approach, 5, published_at: Time.now)
      }

      let(:solution) {
        FactoryGirl.create_list(:solution, 5, published_at: Time.now)
      }

      it 'returns false for an experience' do
        user.experiences << experience
        expect(user.has_draft_submissions?).to eq false
      end

      it 'returns false for an idea' do
        user.ideas << idea
        expect(user.has_draft_submissions?).to eq false
      end

      it 'returns false for an approach' do
        user.approaches << approach
        expect(user.has_draft_submissions?).to eq false
      end

      it 'returns false for a solution' do
        user.solutions << solution
        expect(user.has_draft_submissions?).to eq false
      end

      it 'returns false with an experience, idea, approach, and solution all published' do
        user.experiences << experience
        user.ideas << idea
        user.approaches << approach
        user.solutions << solution
        expect(user.has_draft_submissions?).to eq false
      end
    end
  end
end
