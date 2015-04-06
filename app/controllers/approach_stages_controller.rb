class ApproachStagesController < ApplicationController

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @approach_stage = @challenge.approach_stage
    @approach_ideas = @approach_stage.approach_ideas
  end

end
