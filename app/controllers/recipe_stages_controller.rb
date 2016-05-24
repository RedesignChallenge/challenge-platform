class RecipeStagesController < ApplicationController

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @recipe_stage = @challenge.recipe_stage
    @cookbooks = @recipe_stage.cookbooks
    @featured_recipes = @recipe_stage.recipes.where(featured: true)
  end
end
