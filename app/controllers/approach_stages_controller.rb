class ApproachStagesController < ApplicationController

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @approach_stage = @challenge.approach_stage
    @approach_ideas = @approach_stage.approach_ideas
    @featured_approaches = @approach_stage.featured_approaches
    @featured_approach_comments = @approach_stage.featured_approach_comments
  end
end
