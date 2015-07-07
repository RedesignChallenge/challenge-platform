require 'rails_helper'

describe SuggestionsController do 

  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
  let(:suggestion) { FactoryGirl.create(:suggestion, user: user) }
  
  describe "GET #new" do 

    it "renders the form for suggestions" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    context "with an authenticated user" do

      before(:each) do
        sign_in user
      end

      context "with a suggestion that can be saved" do
        it "creates a suggestion" do
          post :create, suggestion: {title: "this is a suggestion title", description: "this is a suggestion description"}

          expect(assigns(:suggestion).description).to eq "this is a suggestion description"
        end

        it "updates the suggestion flash message appropriately" do
          post :create, suggestion: {title: "this is a suggestion title", description: "this is a suggestion description"}

          expect(flash[:success]).to eq "You've successfully shared your suggestion. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
        end

        it "redirects to the correct path for this suggestion" do
          post :create, suggestion: {title: "this is a suggestion title", description: "this is a suggestion description"}

          expect(response).to redirect_to("/?locale=en")
        end
      end

      context "with a suggestion that cannot be saved" do

        it "renders the new page" do
          post :create, suggestion: {title: "this is a suggestion title", description: "this is a suggestion description", link: 'ftp://google.com'}

          expect(response).to render_template(:new)
        end
      end
    end

    context "with an unauthenticated user" do
      
      before(:each) do
        sign_out user
      end

      context "with a suggestion that can be saved" do

        it "caches the suggestion" do
          post :create, suggestion: {title: "this is a suggestion title", description: "this is a suggestion description"}

          expect(session[:object]).to_not be_nil
        end

        it "redirects to the correct path" do
          post :create, suggestion: {title: "this is a suggestion title", description: "this is a suggestion description"}

          expect(response).to redirect_to("/preview?class_name=suggestion&locale=en")
        end
      end

      context "with an suggestion that cannot be saved" do
        it "renders the new page" do
          post :create, suggestion: {title: "this is a suggestion title", description: "this is a suggestion description", link: 'ftp://google.com'}

          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe "PATCH #update" do

    before(:each) do
      sign_in user
    end

    context "when the update is successful" do
 
      it "updates the suggestion" do
        request.env['HTTP_REFERER'] = "http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags"
        patch :update, id: suggestion.id, suggestion: { description: "suggestion description update" }

        expect(assigns(:suggestion).description).to eq "suggestion description update"
      end

      it "updates the flash message" do
        request.env['HTTP_REFERER'] = "http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags"
        patch :update, id: suggestion.id, suggestion: {description: "suggestion description update"}

        expect(flash[:success]).to eq "You've successfully updated your suggestion. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
      end

      it "redirects to the correct path after update" do
        request.env['HTTP_REFERER'] = '/?locale=en'
        patch :update, id: suggestion.id, suggestion: { description: "suggestion description update" }

        expect(response).to redirect_to "/?locale=en"
      end
    end

    context "when update is unsuccessful" do

      it "renders the edit page if the update was unsuccessful" do
        patch :update, id: suggestion.id, suggestion: { description: "suggestion description update", link: 'ftp://google.com' }

        expect(response).to render_template(:edit)
      end
    end    
  end

  describe "DELETE #destroy" do

    let(:other_user) { FactoryGirl.create(:user, email: 'evil_user@malicious.com') }

    context "the suggestion user and logged in user are the same" do

      before(:each) do
        request.env['HTTP_REFERER'] = "http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags"
        sign_in user
      end

      it "soft deletes the suggestion" do
        delete :destroy, id: suggestion.id
        expect(assigns(:suggestion).destroyed_at).to_not be_nil
      end

      it 'does not *actually* destroy the entity' do
        delete :destroy, id: suggestion.id
        expect(assigns(:suggestion).destroyed?).to eq false
      end

      it "updates the flash message for delete" do
        delete :destroy, id: suggestion.id
        expect(flash[:success]).to eq "You've successfully deleted your suggestion. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
      end

      it "redirects to the correct path for suggestions" do
        delete :destroy, id: suggestion.id
        expect(response).to redirect_to("/?locale=en")
      end
    end

    context "if the suggestion user and the logged in user are NOT the same" do

      before(:each) do
        request.env['HTTP_REFERER'] = "http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags"
        sign_out user
        sign_in other_user
      end

      it "does not soft delete the suggestion that doesn't belong to the user" do
        delete :destroy, id: suggestion.id
        expect(assigns(:suggestion).destroyed_at).to be_nil
      end
    end
  end

  describe "PUT #like" do

    context "when the user is logged in" do

      before(:each) do
        sign_in user
      end

      it "updates the like status of the suggestion" do
        put :like, id: suggestion.id, vote_weight: 1

        expect(assigns(:suggestion).cached_votes_up).to eq 1
        expect(assigns(:suggestion).get_upvotes(vote_weight: 1, vote_scope: 'rating').length).to eq 1
      end

      it "renders the vote.js.erb file" do
        put :like, id: suggestion.id, format: :js

        expect(response).to render_template :like
      end

      it "redirects if not rendering JavaScript" do
        put :like, id: suggestion.id

        expect(response).to redirect_to("/?locale=en")
      end
    end

    context "when the user is not logged in" do

      before(:each) do
        sign_out user
      end

      it "caches the like" do
        put :like, id: suggestion.id, vote_weight: 2

        expect(session[:like]).to_not be_nil
      end
    end
  end

  describe "PUT #unlike" do

    context "when the user is logged in" do

      before(:each) do
        sign_in user
        suggestion.liked_by(user, vote_scope: "rating", vote_weight: 3)
      end

      it "updates the like status of the suggestion" do
        put :unlike, id: suggestion.id, vote_weight: 3

        expect(assigns(:suggestion).cached_votes_up).to eq 0
        expect(assigns(:suggestion).get_upvotes(vote_scope: 'rating', vote_weight: 3).length).to eq 0      
      end

      it "renders the unlike.js.erb file" do
        put :unlike, id: suggestion.id, format: :js

        expect(response).to render_template :unlike
      end

      it "redirects if not rendering JavaScript" do
        put :unlike, id: suggestion.id

        expect(response).to redirect_to("/?locale=en")
      end

    end
  end

end