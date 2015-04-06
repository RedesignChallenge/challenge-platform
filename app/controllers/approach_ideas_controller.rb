class ApproachIdeasController < ApplicationController

  def show
    @approach_idea = ApproachIdea.find(params[:id])
    @approach_stage = @approach_idea.approach_stage
    @challenge = @approach_idea.challenge
  end

end
