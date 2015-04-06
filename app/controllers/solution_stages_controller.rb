class SolutionStagesController < ApplicationController

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @solution_stage = @challenge.solution_stage
    @solution_stories = @solution_stage.solution_stories
  end

end
