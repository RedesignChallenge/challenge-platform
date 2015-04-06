class IdeasController < ApplicationController
  before_action :load_challenge
  before_action :authenticate_user!,  except: [:new, :create, :show, :like]
  before_action :load_idea,           only:   [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!,     only:   [:edit, :update, :destroy]

  def new
    @idea = Idea.new(problem_statement_id: params[:problem_statement_id], refinement_parent_id: params[:refinement_parent_id])
  end

  def create
    @idea = Idea.new(idea_params)
    if user_signed_in?
      @idea.user = current_user
      if @idea.save
        flash[:success] = "You've successfully shared your idea."
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
    if @idea.update(idea_params)
      flash[:success] = "You've successfully updated your idea."
      redirect_to after_update_object_path_for(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    flash[:success] = "You've successfully deleted your idea."
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
    params.require(:idea).permit(:title, :description, :impact, :implementation, :link, :problem_statement_id, :refinement_parent_id)
  end

  def load_idea
    @idea = Idea.find(params[:id])
    @idea_stage = @idea.idea_stage
  end

  def authorize_user!
    unless @idea.user == current_user
      flash[:danger] = 'You do not have access to that area or operation.'
      redirect_to after_update_object_path_for(@idea)
    end
  end

end