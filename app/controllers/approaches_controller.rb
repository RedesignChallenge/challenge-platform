class ApproachesController < ApplicationController
  before_action :load_challenge
  before_action :authenticate_user!, except: [:new, :create, :show, :like]
  before_action :load_approach,      only:   [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!,    only:   [:edit, :update, :destroy]
  before_action :set_published_at!,  only: [:create, :update]

  def new
    @approach = Approach.new(approach_idea_id: params[:approach_idea_id], refinement_parent_id:  params[:refinement_parent_id])
    @approach.steps.build
  end

  def create
    @approach = Approach.new(approach_params)
    if user_signed_in?
      @approach.user = current_user
      if @approach.save
        flash[:success] = object_flash_message_for(@approach)
        redirect_to after_update_object_path_for(@approach)
      else
        render :new
      end
    else
      if @approach.valid?
        cache_pending_object(@approach)
        redirect_to preview_path(class_name: 'approach')
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
    published = !@approach.published_at? && approach_params[:published_at].present?
    if @approach.update(approach_params)
      flash[:success] = object_flash_message_for(@approach, {published: published})
      redirect_to after_update_object_path_for(@approach)
    else
      render :edit
    end
  end

  def destroy
    @approach.destroy
    flash[:success] = object_flash_message_for(@approach)
    redirect_to after_update_object_path_for(@approach)
  end

  def like
    if user_signed_in?
      @approach.liked_by(current_user, vote_scope: @approach.default_like[:scope])
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@approach) }
        format.js   { render :like, locals: { partial: "#{params[:partial]}" } }
      end
    else
      cache_pending_like(@approach, {vote_scope: @approach.default_like[:scope]})
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def unlike
    @approach.unliked_by(current_user, vote_scope: @approach.default_like[:scope])

    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@approach) }
      format.js   { render :unlike, locals: { partial: "#{params[:partial]}" } }
    end
  end

private

  def approach_params
    params.require(:approach).permit(:title, :description, :needs, :link, :approach_idea_id, :published_at, steps_attributes: [:id, :display_order, :description, :_destroy])
  end

  def load_approach
    @approach = Approach.find(params[:id])
    unless @approach.user == current_user || @approach.published_at?
      flash[:error] = 'Sorry, that approach has not been published yet.'
      redirect_to challenge_approach_stage_path(@challenge, @approach.approach_stage)
    end
    @approach_stage = @approach.approach_stage
  end

  def authorize_user!
    unless @approach.user == current_user
      flash[:danger] = 'You do not have access to that area or operation.'
      redirect_to after_update_object_path_for(@approach)
    end
  end

  def set_published_at!
    params[:approach][:published_at] = params[:approach][:published] == 'true' ? Time.now : nil
  end

end