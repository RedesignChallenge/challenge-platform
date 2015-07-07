require 'rails_helper'

shared_examples_for 'a standard controller' do

  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
  let(:challenge) { FactoryGirl.create(:challenge) }
  let(:target_model) { resolve_model_name(described_class) }

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new, challenge_id: challenge.id,
          :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
          :"#{underscore(third_fragment.class)}_id" => third_fragment.id

      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    context 'with a user that is logged in and owns the fetched entity' do

      let(:user) {
        FactoryGirl.create(:user)
      }

      before(:each) {
        sign_in user
      }

      it 'renders the :show template' do
        get :show, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: unpublished_entity.id

        expect(response).to render_template(:show)
      end

      it 'sets the current entity to the published entity' do
        # unpublished_entity
        get :show, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: unpublished_entity.id

        expect(assigns(target_model)).to eq unpublished_entity
      end
    end

    context 'with a user that is logged in and does not own the fetched entity' do

      let(:user) {
        FactoryGirl.create(:user)
      }

      let(:other_user) {
        FactoryGirl.create(:user)
      }

      before(:each) {
        sign_out user
        sign_in other_user
      }

      it 'redirects to the stage fragment for the entity' do
        get :show, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: unpublished_entity.id

        expect(response).to redirect_to "/en/challenges/#{assigns(target_model).challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}"
      end

      it 'updates the flash message with an error' do
        get :show, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: unpublished_entity.id

        expect(flash[:error]).to eq "Sorry, that #{target_model} has not been published yet."
      end
    end

    context 'with a user that is not logged in' do
      let(:user) {
        FactoryGirl.create(:user)
      }

      before(:each) {
        unpublished_entity.user = user
        sign_out user
      }

      it 'redirects to the stage fragment for the entity' do
        get :show, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: unpublished_entity.id

        expect(response).to redirect_to "/en/challenges/#{assigns(target_model).challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}"
      end

      it 'updates the flash message with an error' do
        get :show, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: unpublished_entity.id

        expect(flash[:error]).to eq "Sorry, that #{target_model} has not been published yet."
      end
    end
  end

  describe 'POST #create' do

    context 'with an authenticated user' do
      before(:each) do
        sign_in user
      end

      context 'with an entity that can be persisted' do

        it 'creates the controller\'s entity' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => savable_entity
          expect(assigns(target_model).published_at).to_not be_nil
          expect(assigns(target_model).persisted?).to eq true
        end

        it 'creates the a draft entity' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => draft_entity
          expect(assigns(target_model).published_at).to be_nil
          expect(assigns(target_model).persisted?).to eq true
        end

        it 'updates the flash message' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => savable_entity
          expect(flash[:success]).to eq "You've successfully shared your #{target_model}. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
        end

        it 'updates the flash message for a draft entity' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => draft_entity
          expect(flash[:success]).to eq "You've successfully saved a draft of your #{target_model}. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
        end

        it 'redirects correctly after creation' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => savable_entity
          expect(response).to redirect_to redirect_path || "/en/challenges/#{assigns(target_model).challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}/#{underscore_and_pluralize(third_fragment.class)}/#{third_fragment.id}/#{pluralize(target_model)}/#{assigns(target_model).id}"
        end
      end

      context 'with an entity that cannot be persisted' do
        it 'renders the :new page' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => unsavable_entity
          expect(response).to render_template(:new)
        end
      end
    end

    context 'with an unauthenticated user' do
      before(:each) do
        sign_out user
      end

      context 'with an entity that can be persisted' do
        it 'stores the entity in the cache' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => savable_entity

          expect(session[:object]).to_not be_nil
        end

        it 'redirects to the appropriate preview page' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => savable_entity
          expect(response).to redirect_to("/preview?class_name=#{target_model}&locale=en")
        end
      end

      context 'with an entity that cannot be persisted' do
        it 'renders the :new page' do
          post :create, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               :"#{target_model}" => unsavable_entity
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'PATCH #update' do

    before(:each) do
      request.env['HTTP_REFERER'] = 'http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags'
      sign_in user
    end

    context 'when the entity can be updated' do

      it 'updates the preexisting entity' do
        patch :update, challenge_id: challenge.id,
              :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
              :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
              id: preexisting_entity.id,
              :"#{target_model}" => valid_patch_model

        expect(assigns(target_model).link).to eq valid_patch_model[:link]
        expect(assigns(target_model).description).to eq valid_patch_model[:description]
        expect(assigns(target_model).persisted?).to eq true
        expect(assigns(target_model).published_at).to be_nil

      end

      it 'sets the flash message correctly' do
        patch :update, challenge_id: challenge.id,
              :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
              :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
              id: preexisting_entity.id,
              :"#{target_model}" => valid_patch_model
        expect(flash[:success]).to eq "You've successfully updated the draft of your #{target_model}. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
      end

      it 'redirects to the correct path' do
        patch :update, challenge_id: challenge.id,
              :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
              :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
              id: preexisting_entity.id,
              :"#{target_model}" => valid_patch_model
        expect(response).to redirect_to redirect_path || "/en/challenges/#{assigns(target_model).challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}/#{underscore_and_pluralize(third_fragment.class)}/#{third_fragment.id}/#{pluralize(target_model)}/#{assigns(target_model).id}"
      end
    end

    context 'when the entity is a draft' do

      it 'updates the preexisting entity with a timestamp' do
        patch :update, challenge_id: challenge.id,
              :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
              :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
              id: unpublished_entity.id,
              :"#{target_model}" => valid_patch_publish_model

        expect(assigns(target_model).link).to eq valid_patch_publish_model[:link]
        expect(assigns(target_model).description).to eq valid_patch_publish_model[:description]
        expect(assigns(target_model).persisted?).to eq true
        expect(assigns(target_model).published_at).to_not be_nil

      end

      it 'sets the flash message correctly' do
        patch :update, challenge_id: challenge.id,
              :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
              :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
              id: unpublished_entity.id,
              :"#{target_model}" => valid_patch_publish_model
        expect(flash[:success]).to eq "You've successfully published your #{target_model}. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
      end
    end

    context 'when the entity cannot be updated' do
      it 'renders the :edit action' do
        patch :update, challenge_id: challenge.id,
              :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
              :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
              id: preexisting_entity.id,
              :"#{target_model}" => invalid_patch_model
        expect(response).to render_template :edit

      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with a user that owns the entity' do

      before(:each) do
        sign_in user
        request.env['HTTP_REFERER'] = 'http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags'
      end

      it 'updates the destroyed_at column' do
        delete :destroy, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               id: preexisting_entity.id
        expect(assigns(target_model).destroyed_at).to_not be_nil
      end

      it 'sets the appropriate flash message' do
        delete :destroy, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               id: preexisting_entity.id
        expect(flash[:success]).to eq "You've successfully deleted your #{target_model}. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
      end

      it 'redirects to the appropriate path' do
        delete :destroy, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               id: preexisting_entity.id
        expect(response).to redirect_to "/en/challenges/#{assigns(target_model).challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}"
      end

      it 'does not *actually* destroy the entity' do
        delete :destroy, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               id: preexisting_entity.id
        expect(preexisting_entity.deleted?).to eq false
      end
    end

    context 'with a user that does not own the entity' do

      let(:other_user) {
        FactoryGirl.create(:user, email: Faker::Internet.email)
      }

      before(:each) do
        request.env['HTTP_REFERER'] = 'http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags'
        sign_out user
        sign_in other_user
      end

      it 'does not update the destroyed_at column' do
        delete :destroy, challenge_id: challenge.id,
               :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
               :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
               id: preexisting_entity.id
        expect(assigns(target_model).destroyed_at).to be_nil
      end
    end
  end

  describe 'PUT #like' do

    context 'with an authenticated user' do
      before(:each) do
        sign_in user
      end

      it 'creates a vote on the entity' do
        put :like, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(assigns(target_model).get_upvotes(vote_scope: preexisting_entity.default_like[:scope]).length).to eq 1
      end
    end

    context 'with an unauthenticated user' do

      before(:each) do
        sign_out user
      end

      it 'stores their like in the cache' do
        put :like, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(session[:like]).to_not be_nil
      end
    end
  end

  describe 'PUT #unlike' do
    context 'with an authenticated user' do

      before(:each) do
        preexisting_entity.liked_by(user, vote_scope: preexisting_entity.default_like[:scope])
        sign_in user
      end

      it 'unupvotes the like on the entity' do
        put :unlike, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(assigns(target_model).get_upvotes(vote_scope: preexisting_entity.default_like[:scope]).size).to eq 0
      end

      it 'responds with JavaScript when calling via JavaScript' do
        put :unlike, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id, format: :js
        expect(response).to render_template :unlike
      end
      it 'redirects when calling via HTML' do
        put :unlike, challenge_id: challenge.id,
            :"#{underscore(second_fragment.class)}_id" => second_fragment.id,
            :"#{underscore(third_fragment.class)}_id" => third_fragment.id,
            id: preexisting_entity.id
        expect(response).to redirect_to redirect_path || "/en/challenges/#{assigns(target_model).challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}/#{underscore_and_pluralize(third_fragment.class)}/#{third_fragment.id}/#{pluralize(target_model)}/#{assigns(target_model).id}"
      end
    end
  end

  def underscore(cls)
    ActiveSupport::Inflector.underscore(cls.to_s)
  end

  def underscore_and_pluralize(cls)
    pluralize(underscore(cls))
  end

  def pluralize(s)
    ActiveSupport::Inflector.pluralize(s)
  end

  def resolve_model_name(described_class)
    ActiveSupport::Inflector.singularize(described_class.controller_path)
  end

  def build_redirect_path(second_fragment, target_model=nil)
    if target_model
      "/en/challenges/#{challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}/#{underscore_and_pluralize(third_fragment.class)}/#{third_fragment.id}/#{pluralize(target_model)}/#{assigns(target_model).id}"
    else
      "/en/challenges/#{challenge.slug}/#{underscore_and_pluralize(second_fragment.class)}/#{second_fragment.id}"
    end
  end
end