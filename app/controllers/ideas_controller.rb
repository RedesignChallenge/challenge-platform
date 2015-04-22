class IdeasController < ApplicationController
  before_action :load_challenge
  before_action :authenticate_user!,  except: [:new, :create, :show, :like]
  before_action :load_idea,           only:   [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!,     only:   [:edit, :update, :destroy]
  before_action :set_published_at!,   only: [:create, :update]

  def new
    @idea = Idea.new(problem_statement_id: params[:problem_statement_id], refinement_parent_id: params[:refinement_parent_id])
  end

  def create
    @idea = Idea.new(idea_params)
    if user_signed_in?
      @idea.user = current_user
      if @idea.save
        flash[:success] = object_flash_message_for(@idea)
        redirect_to after_update_object_path_for(@idea)
      else
        render :new
      end
    else
      if @idea.valid?
        cache_pending_object(@idea)
        redirect_to preview_path(class_name: 'idea')
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
    published = !@idea.published_at? && idea_params[:published_at].present?
    if @idea.update(idea_params)
      flash[:success] = object_flash_message_for(@idea, {published: published})
      redirect_to after_update_object_path_for(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    flash[:success] = object_flash_message_for(@idea)
    redirect_to after_update_object_path_for(@idea)
  end

  def like
    if user_signed_in?
      @idea.liked_by(current_user, vote_scope: @idea.default_like[:scope])
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@idea) }
        format.js   { render :like, locals: { partial: "#{params[:partial]}" } }
      end
    else
      cache_pending_like(@idea, {vote_scope: @idea.default_like[:scope]})
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def unlike
    @idea.unliked_by(current_user, vote_scope: @idea.default_like[:scope])
    
    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@idea) }
      format.js   { render :unlike, locals: { partial: "#{params[:partial]}" } }
    end
  end

private

  def idea_params
    params.require(:idea).permit(:title, :description, :impact, :implementation, :link, :problem_statement_id, :refinement_parent_id, :published_at)
  end

  def load_idea
    @idea = Idea.find(params[:id])
    unless @idea.user == current_user || @idea.published_at?
      flash[:error] = 'Sorry, that idea has not been published yet.'
      redirect_to challenge_idea_stage_path(@challenge, @idea.idea_stage)
    end
    @idea_stage = @idea.idea_stage
  end

  def authorize_user!
    unless @idea.user == current_user
      flash[:danger] = 'You do not have access to that area or operation.'
      redirect_to after_update_object_path_for(@idea)
    end
  end

  def set_published_at!
    params[:idea][:published_at] = params[:idea][:published] == 'true' ? Time.now : nil
  end

end