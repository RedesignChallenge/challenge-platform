class ExperiencesController < ApplicationController
  before_action :load_challenge
  before_action :authenticate_user!,  except: [:new, :create, :show, :like]
  before_action :load_experience,     only:   [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!,     only:   [:edit, :update, :destroy]

  def new
    @experience = Experience.new(theme_id: params[:theme_id])
  end

  def create
    @experience = Experience.new(experience_params)
    if user_signed_in?
      @experience.user = current_user
      if @experience.save
        flash[:success] = "You've successfully shared your experience."
        redirect_to after_update_object_path_for(@experience)
      else
        render :new
      end
    else
      if @experience.valid?
        cache_pending_object(@experience)
        redirect_to preview_path(class_name: 'experience')
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @experience.update(experience_params)
      flash[:success] = "You've successfully updated your experience."
      redirect_to after_update_object_path_for(@experience)
    else
      render :edit
    end
  end

  def destroy
    @experience.destroy
    flash[:success] = "You've successfully deleted your experience."
    redirect_to after_update_object_path_for(@experience)
  end

  def like
    if user_signed_in?
      @experience.liked_by(current_user, vote_scope: @experience.default_like[:scope])
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@experience) }
        format.js   { render :like, locals: { partial: "#{params[:partial]}" } }
      end
    else
      cache_pending_like(@experience, {vote_scope: @experience.default_like[:scope]})
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def unlike
    @experience.unliked_by(current_user, vote_scope: @experience.default_like[:scope])
    
    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@experience) }
      format.js   { render :unlike, locals: { partial: "#{params[:partial]}" } }
    end
  end

private
  
  def experience_params
    params.require(:experience).permit(:description, :link, :theme_id)
  end

  def load_experience
    @experience = Experience.find(params[:id])
    @experience_stage = @experience.experience_stage
  end

  def authorize_user!
    unless @experience.user == current_user
      flash[:danger] = 'You do not have access to that area or operation.'
      redirect_to after_update_object_path_for(@experience)
    end
  end

end