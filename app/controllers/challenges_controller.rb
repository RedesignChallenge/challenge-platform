class ChallengesController < ApplicationController

  def index
    redirect_to Challenge.featured ? challenge_path(Challenge.featured) : root_path
  end

  def show
    @challenge = Challenge.find(params[:id])

    if request.path != challenge_path(@challenge)
      flash.keep
      redirect_to challenge_path(@challenge), status: :moved_permanently
    end
  end
end
