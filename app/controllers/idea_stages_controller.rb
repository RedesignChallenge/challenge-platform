class IdeaStagesController < ApplicationController

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @idea_stage = @challenge.idea_stage
    @problem_statements = @idea_stage.problem_statements
    @featured_ideas = @idea_stage.ideas.where(featured: true)
  end
end
