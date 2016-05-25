class RecipesController < ApplicationController
  before_action :load_challenge
  before_action :authenticate_user!, except: [:new, :create, :show, :like, :try]
  before_action :load_recipe,        only:   [:show, :edit, :update, :destroy, :like, :unlike, :try, :untry]
  before_action :authorize_user!,    only:   [:edit, :update, :destroy]
  before_action :set_published_at!,  only:   [:create, :update]

  def new
    @recipe = Recipe.new(cookbook_id: params[:cookbook_id], refinement_parent_id:  params[:refinement_parent_id])
    @recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if user_signed_in?
      @recipe.user = current_user
      if @recipe.save
        flash[:success] = object_flash_message_for(@recipe)
        redirect_to after_update_object_path_for(@recipe)
      else
        render :new
      end
    else
      if @recipe.valid?
        cache_pending_object(@recipe)
        redirect_to preview_path(class_name: 'recipe')
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    published = !@recipe.published_at? && recipe_params[:published_at].present?
    if @recipe.update(recipe_params)
      flash[:success] = object_flash_message_for(@recipe, {published: published})
      redirect_to after_update_object_path_for(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = object_flash_message_for(@recipe)
    redirect_to after_update_object_path_for(@recipe)
  end

  def like
    if user_signed_in?
      @recipe.liked_by(current_user, vote_scope: @recipe.default_like[:scope])
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@recipe) }
        format.js   { render :like, locals: { partial: "#{params[:partial]}" } }
      end
    else
      cache_pending_like(@recipe, {vote_scope: @recipe.default_like[:scope]})
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def unlike
    @recipe.unliked_by(current_user, vote_scope: @recipe.default_like[:scope])

    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@recipe) }
      format.js   { render :unlike, locals: { partial: "#{params[:partial]}" } }
    end
  end

  def try
    if user_signed_in?
      @recipe.liked_by(current_user, vote_scope: 'try')
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@recipe) }
        format.js   { render :try, locals: { partial: "#{params[:partial]}" } }
      end
    else
      cache_pending_like(@recipe, {vote_scope: 'try'})
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def untry
    @recipe.unliked_by(current_user, vote_scope: 'try')

    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@recipe) }
      format.js   { render :untry, locals: { partial: "#{params[:partial]}" } }
    end
  end

private

  def recipe_params
    params.require(:recipe).permit(
      :title, 
      :description, 
      :materials, 
      :community,
      :conditions, 
      :evidence, 
      :protips, 
      :link, 
      :cookbook_id, 
      :published_at, 
      steps_attributes: [:id, :display_order, :description, :_destroy]
    )
  end

  def load_recipe
    @recipe = Recipe.find(params[:id])
    unless @recipe.user == current_user || @recipe.published_at?
      flash[:error] = 'Sorry, that recipe has not been published yet.'
      redirect_to challenge_recipe_stage_path(@challenge, @recipe.recipe_stage)
    end
    @recipe_stage = @recipe.recipe_stage
  end

  def authorize_user!
    unless @recipe.user == current_user
      flash[:danger] = 'You do not have access to that area or operation.'
      redirect_to after_update_object_path_for(@recipe)
    end
  end

  def set_published_at!
    params[:recipe][:published_at] = params[:recipe][:published] == 'true' ? Time.now : nil
  end

end