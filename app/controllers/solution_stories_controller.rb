class SolutionStoriesController < ApplicationController

  def show
    @solution_story = SolutionStory.find(params[:id])
    @solution = @solution_story.solution
    @solution_stage = @solution_story.solution_stage
    @challenge = @solution_story.challenge
  end

end
