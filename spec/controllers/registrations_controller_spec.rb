require 'rails_helper'
require 'faker'
require 'sidekiq/testing'

describe RegistrationsController do
  describe 'PATCH #update' do

    let(:user) {
      FactoryGirl.create(:user, avatar_option: 'twitter')
    }

    let(:upload) {
      ActionDispatch::Http::UploadedFile.new(
          {
              filename: 'avatar.png',
              content_type: 'image/png',
              tempfile: File.new("#{Rails.root}/spec/support/images/small_image.png")
          }
      )
    }

    before(:each) {
      sign_in user
      request.env['devise.mapping'] = Devise.mappings[:user]
    }

    it 'uses no avatar if the \'none\' option is specified' do
      patch :update, user: {id: user.id, avatar_option: 'none'}
      resultant_user = User.find(user.id)
      expect(resultant_user.avatar_option).to eq 'none'
      expect(resultant_user.avatar.present?).to eq false
    end

    it 'uses Twitter if the \'Twitter\' option is specified' do
      patch :update, user: {id: user.id, avatar_option: 'twitter', twitter: 'test12345'}
      user.reload
      expect(user.avatar_option).to eq 'twitter'
      # The User object is using Sidekiq to handle async job processing.
      # We want to check that the object has made its way into the queue.
      expect(Sidekiq::Worker.jobs.size).to eq 1
      expect(user.avatar.present?).to eq false
      expect(user.twitter).to_not be_nil
    end

    it 'uses an uploaded file in all other cases' do
      patch :update, user: {id: user.id, avatar_option: 'upload', avatar: upload}
      resultant_user = User.find(user.id)
      expect(resultant_user.avatar_option).to eq 'upload'
      expect(resultant_user.avatar.present?).to eq true
    end
  end
end