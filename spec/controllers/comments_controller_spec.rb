require 'rails_helper'

describe CommentsController do

  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
  let(:idea) {
    idea = FactoryGirl.create(:idea, user: FactoryGirl.create(:user))
    idea_stage = FactoryGirl.create(:idea_stage)
    challenge = FactoryGirl.create(:challenge)
    problem_statement = FactoryGirl.create(:problem_statement)

    challenge.idea_stage = idea_stage
    idea_stage.problem_statements << problem_statement
    problem_statement.ideas << idea
    idea
  }
  let(:comment) { FactoryGirl.create(:comment, commentable: idea, user: user) }

  describe 'GET #new' do
    it 'renders the form for comments' do
      get :new, commentable_type: 'Idea', commentable_id: idea.id

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do

    context 'with an authenticated user' do

      before(:each) do
        sign_in user
      end

      it 'creates a comment' do
        post :create, comment: {body: 'This is a body of text!', link: 'http://youtu.be/rJGifTou5FE', commentable_type: 'Idea', commentable_id: idea.id}

        expect(assigns(:comment).body).to eq 'This is a body of text!'
        expect(assigns(:comment).link).to eq 'http://youtu.be/rJGifTou5FE'
        expect(assigns(:comment).commentable).to eq idea
        expect(assigns(:comment).persisted?).to eq true
      end

      context 'with a comment that can be saved' do

        it 'updates the flash message appropriately' do
          post :create, comment: {body: "Everything is cool when you're part of a team!", link: 'http://youtu.be/StTqXEQ2l-Y', commentable_type: 'Idea', commentable_id: idea.id}

          expect(flash[:success]).to eq "You've successfully shared your comment. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
        end

        it 'redirects to the correct path for this particular commentable entity' do
          post :create, comment: {body: "Everything is cool when you're part of a team!", link: 'http://youtu.be/StTqXEQ2l-Y', commentable_type: 'Idea', commentable_id: idea.id}

          expect(response).to redirect_to("/en/challenges/#{idea.challenge.slug}/idea_stages/#{idea.idea_stage.id}/problem_statements/#{idea.problem_statement.id}/ideas/#{idea.id}")
        end

        it 'queues a mail job' do
          post :create, comment: {body: "This is for emails", commentable_type: 'Idea', commentable_id: idea.id}
          expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 1
        end
      end

      context 'with a comment that has an attached parent id' do

        let(:existing_comment) { FactoryGirl.create(:comment, commentable: idea) }

        it 'attaches the new comment to the child' do
          post :create, comment: {body: "Everything is awesome when you're living on a dream!", link: 'http://youtu.be/StTqXEQ2l-Y',commentable_type: 'Idea', commentable_id: idea.id, temporal_parent_id: existing_comment.id}

          expect(assigns(:comment).parent_id).to eq existing_comment.id
          expect(existing_comment.has_children?).to be true
        end


        it 'queues two mail jobs' do
          post :create, comment: {body: "This is for emails", commentable_type: 'Idea', commentable_id: idea.id, temporal_parent_id: existing_comment.id}
          expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 2
        end
      end

      context 'with a comment that cannot be saved' do

        it 'renders the :new page' do
          post :create, comment: {body: 'sadness.jpg', link: 'ftp://google.com', commentable_type: 'Idea', commentable_id: idea.id}

          expect(response).to render_template(:new)
        end
      end
    end

    context 'with an unauthenticated user' do

      before(:each) do
        sign_out user
      end

      it 'caches the comment' do
        post :create, comment: {body: "Everything is cool when you're part of a team!", link: 'http://youtu.be/StTqXEQ2l-Y', commentable_type: 'Idea', commentable_id: idea.id}

        expect(session[:object]).to_not be_nil
      end

      it 'redirects to the preview path' do
        post :create, comment: {body: "Everything is cool when you're part of a team!", link: 'http://youtu.be/StTqXEQ2l-Y', commentable_type: 'Idea', commentable_id: idea.id}

        expect(response).to redirect_to '/preview?class_name=comment'
      end

      it 'renders new if the comment is invalid' do
        post :create, comment: {body: 'sadness.jpg', link: 'ftp://google.com', commentable_type: 'Idea', commentable_id: idea.id}

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do

    let(:other_user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
    end

    it 'soft deletes the entity' do
      delete :destroy, id: comment.id

      expect(assigns(:comment).destroyed_at).to_not be_nil
    end

    it 'does not *actually* destroy the entity' do
      delete :destroy, id: comment.id
      expect(assigns(:comment).destroyed?).to eq false
    end

    it 'redirects to the correct path for ideas' do
      delete :destroy, id: comment.id

      expect(response).to redirect_to("/en/challenges/#{idea.challenge.slug}/idea_stages/#{idea.idea_stage.id}/problem_statements/#{idea.problem_statement.id}/ideas/#{idea.id}")
    end

    it 'updates the flash message appropriately' do
      delete :destroy, id: comment.id

      expect(flash[:success]).to eq "You've successfully deleted your comment. <a href='/users/#{user.id}?locale=en'>Click here</a> to see all of your contributions."
    end

    context 'if the commented user and the logged in user are not the same' do

      before(:each) do
        sign_out user
        sign_in other_user
      end

      it 'does not soft delete a comment that does not belong to the user' do
        request.env['HTTP_REFERER'] = 'http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags'
        delete :destroy, id: comment.id

        expect(assigns(:comment).destroyed_at).to be_nil
      end
    end
  end

  describe 'PUT #like' do

    context 'when the user is logged in' do

      before(:each) do
        sign_in user
      end

      it 'updates the like status of the comment' do
        put :like, id: comment.id

        expect(assigns(:comment).cached_votes_up).to eq 1
        expect(assigns(:comment).get_upvotes(vote_scope: comment.default_like[:scope]).length).to eq 1
      end

      it 'renders the like.js.erb file' do
        put :like, id: comment.id, format: :js

        expect(response).to render_template :like
      end

      it 'redirects if not rendering JavaScript' do
        put :like, id: comment.id

        expect(response).to redirect_to "/en/challenges/#{idea.challenge.slug}/idea_stages/#{idea.idea_stage.id}/problem_statements/#{idea.problem_statement.id}/ideas/#{idea.id}"
      end
    end

    context 'when the user is not logged in' do

      before(:each) do
        sign_out user
      end

      it 'caches the like' do
        put :like, id: comment.id

        expect(session[:like]).to_not be_nil
      end
    end
  end

  describe 'PUT #unlike' do

    context 'when the user is logged in' do

      before(:each) do
        sign_in user
        comment.liked_by(user, vote_scope: comment.default_like[:scope])
      end

      it 'updates the like status of the comment' do
        put :unlike, id: comment.id

        expect(assigns(:comment).cached_votes_up).to eq 0
        expect(assigns(:comment).get_upvotes(vote_scope: comment.default_like[:scope]).length).to eq 0
      end

      it 'renders the unlike.js.erb file' do
        put :unlike, id: comment.id, format: :js

        expect(response).to render_template :unlike
      end

      it 'redirects if not rendering JavaScript' do
        put :unlike, id: comment.id
        
        expect(response).to redirect_to "/en/challenges/#{idea.challenge.slug}/idea_stages/#{idea.idea_stage.id}/problem_statements/#{idea.problem_statement.id}/ideas/#{idea.id}"
      end
    end
  end
end