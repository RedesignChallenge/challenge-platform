class ExperienceStagesController < ApplicationController

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @experience_stage = @challenge.experience_stage
    @themes = @experience_stage.themes
  end

end
