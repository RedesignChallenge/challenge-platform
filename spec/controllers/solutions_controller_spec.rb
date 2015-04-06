require 'rails_helper'

describe SolutionsController do 

  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
  let(:challenge) { FactoryGirl.create(:challenge) }
  let(:solution_stage) {
    solution_stage = FactoryGirl.create(:solution_stage)
    challenge.solution_stage = solution_stage
    solution_stage
  }
  let(:solution_story) {
    solution_story = FactoryGirl.create(:solution_story)
    solution_stage.solution_stories << solution_story
    solution_story
  }
  let(:solution) {
    solution = FactoryGirl.create(:solution, user: user)
    solution_story.solution = solution
    solution
  }

  describe "PUT #like" do

    context "when the user is logged in" do

      before(:each) do
        sign_in user
      end

      it "updates the like status of the solution" do
        put :like, challenge_id: solution.challenge.id, solution_stage_id: solution.solution_stage.id, solution_story_id: solution.solution_story.id, id: solution.id

        expect(assigns(:solution).get_upvotes(vote_scope: solution.default_like[:scope]).size).to eq 1
      end

      it "renders the like.js.erb file" do
        put :like, challenge_id: solution.challenge.id, solution_stage_id: solution.solution_stage.id, solution_story_id: solution.solution_story.id, id: solution.id, format: :js

        expect(response).to render_template :like
      end

      it "redirects if not rendering JavaScript" do
        put :like, challenge_id: solution.challenge.id, solution_stage_id: solution.solution_stage.id, solution_story_id: solution.solution_story.id, id: solution.id

        expect(response).to redirect_to("/challenges/#{assigns(:solution).challenge.slug}/solution_stages/#{assigns(:solution).solution_stage.id}/solution_stories/#{assigns(:solution).solution_story.id}")
      end
    end

    context "when the user is not logged in" do

      before(:each) do
        sign_out user
      end

      it "caches the like" do
        put :like, challenge_id: solution.challenge.id, solution_stage_id: solution.solution_story.solution_stage.id, solution_story_id: solution.solution_story.id, id: solution.id

        expect(session[:like].length).to_not be_nil      
      end
    end
  end

  describe "PUT #unlike" do

    context "when the user is logged in" do

      before(:each) do
        solution.liked_by(user, vote_scope: solution.default_like[:scope])
        sign_in user
      end

      it "updates the unlike status of the solution" do
        put :unlike, challenge_id: solution.challenge.id, solution_stage_id: solution.solution_stage.id, solution_story_id: solution.solution_story.id, id: solution.id

        expect(assigns(:solution).get_upvotes(vote_scope: solution.default_like[:scope]).size).to eq 0
      end

      it "renders the unlike.js.erb file" do
        put :unlike, challenge_id: solution.challenge.id, solution_stage_id: solution.solution_stage.id, solution_story_id: solution.solution_story.id, id: solution.id, format: :js

        expect(response).to render_template :unlike
      end

      it "redirects if not rendering JavaScript" do
        put :unlike, challenge_id: solution.challenge.id, solution_stage_id: solution.solution_stage.id, solution_story_id: solution.solution_story.id, id: solution.id

        expect(response).to redirect_to("/challenges/#{assigns(:solution).challenge.slug}/solution_stages/#{assigns(:solution).solution_stage.id}/solution_stories/#{assigns(:solution).solution_story.id}")
      end
    end
  end

end