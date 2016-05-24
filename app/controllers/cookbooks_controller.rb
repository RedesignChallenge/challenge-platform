class CookbooksController < ApplicationController

  def show
    @cookbook = Cookbook.find(params[:id])
    @recipe_stage = @cookbook.recipe_stage
    @challenge = @cookbook.challenge
  end

end
