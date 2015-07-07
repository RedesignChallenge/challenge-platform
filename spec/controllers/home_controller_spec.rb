require 'rails_helper'

describe HomeController do
  describe 'GET #index' do

    it 'renders the correct home page' do
      get 'index'
      expect(response).to render_template 'home'
    end

    context 'with two featured challenges, and the first has not ended' do

      let!(:first_challenge) {
        FactoryGirl.create(:challenge, title: 'Primary challenge', featured: true, starts_at: 30.days.ago, ends_at: 5.minutes.from_now)
      }

      let!(:second_challenge) {
        FactoryGirl.create(:challenge, title: 'Secondary challenge', featured: true, starts_at: 5.minutes.from_now, ends_at: 30.days.from_now)
      }

      it 'pulls in the first challenge' do
        get 'index'
        expect(assigns(:featured)).to eq first_challenge
      end
    end

    context 'with two featured challenges, and the first has ended' do
      let!(:first_challenge) {
        FactoryGirl.create(:challenge, title: 'Primary challenge', featured: true, starts_at: 30.days.ago, ends_at: Time.now)
      }

      let!(:second_challenge) {
        FactoryGirl.create(:challenge, title: 'Secondary challenge', featured: true, starts_at: Time.now, ends_at: 30.days.from_now)
      }

      it 'pulls in the second challenge' do
        get 'index'
        expect(assigns(:featured)).to eq second_challenge
      end
    end

    context 'with two unfeatured challenges' do
      let!(:first_challenge) {
        FactoryGirl.create(:challenge, title: 'Primary challenge', featured: false, starts_at: 30.days.ago, ends_at: Time.now)
      }

      let!(:second_challenge) {
        FactoryGirl.create(:challenge, title: 'Secondary challenge', featured: false, starts_at: Time.now, ends_at: 30.days.from_now)
      }

      it 'pulls nothing in' do
        get 'index'
        expect(assigns(:featured)).to be_nil
      end
    end

    context 'with one featured challenge that started two hours ago' do
      let!(:first_challenge) {
        FactoryGirl.create(:challenge, title: 'Primary challenge', featured: false, starts_at: 30.days.ago, ends_at: 30.days.from_now)
      }

      let!(:second_challenge) {
        FactoryGirl.create(:challenge, title: 'Secondary challenge', featured: true, starts_at: 2.hours.ago, ends_at: 30.days.from_now)
      }

      it 'pulls the second challenge in' do
        get 'index'
        expect(assigns(:featured)).to eq second_challenge
      end
    end

    context 'with two featured challenges, with the first over and the second not yet to start' do

      let!(:first_challenge) {
        FactoryGirl.create(:challenge, title: 'Primary challenge', featured: true, starts_at: 30.days.ago, ends_at: Time.now)
      }

      let!(:second_challenge) {
        FactoryGirl.create(:challenge, title: 'Secondary challenge', featured: true, starts_at: 5.minutes.from_now, ends_at: 30.days.from_now)
      }

      it 'pulls nothing in' do
        get 'index'
        expect(assigns(:featured)).to be_nil
      end
    end
  end

  describe 'GET #preview' do
    let(:comment) { FactoryGirl.create(:comment) }

    it 'hides the navigation bars' do
      get 'preview', class_name: 'inconsequential'
      expect(assigns(:hide_navs)).to be true
    end

    it 'loads the votable type from the session object when vote is a query parameter' do
      session[:like] = {likeable_type: 'Comment', likeable_id: comment.id, vote_scope: 'like'}
      get 'preview', class_name: 'vote'
      expect(assigns(:object)).to eq comment
    end

    it 'loads the correct object in from the session when vote is not the query parameter' do
      session[:object] = comment
      get 'preview', class_name: comment.class.to_s.downcase
      expect(assigns(:object)).to eq comment
      expect(flash[:danger]).to be_nil
    end

    context 'when rejecting previews' do
      it 'rejects bogus query parameter entries' do
        session[:object] = comment
        get 'preview', class_name: 'This is the song that never ends; yes it goes on and on my friend'
        expect(flash[:danger]).to eq 'Sorry there is no preview to be shown. Please try again.'
      end

      it 'rejects a preview that does not match the session entity' do
        session[:object] = comment
        get 'preview', class_name: 'idea'
        expect(flash[:danger]).to eq 'Sorry there is no preview to be shown. Please try again.'
      end

      it 'rejects a preview if there is nothing in the session' do
        get 'preview', class_name: 'experience'
        expect(flash[:danger]).to eq 'Sorry there is no preview to be shown. Please try again.'
      end

      it 'redirects to the referrer location if specified' do
        request.env['HTTP_REFERER'] = 'http://www.stackoverflow.com'
        get 'preview', class_name: 'bogus'
        expect(response).to redirect_to 'http://www.stackoverflow.com'
      end

      it 'redirects to the root path if no referrer is specified' do
        get 'preview', class_name: 'bogus'
        expect(response).to redirect_to '/?locale=en'
      end
    end
  end
end