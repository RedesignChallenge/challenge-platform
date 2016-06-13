class SuggestionsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :like]
  before_action :load_suggestion, only: [:edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    if user_signed_in?
      @suggestion.user = current_user
      if @suggestion.save
        flash[:success] = object_flash_message_for(@suggestion)
        redirect_to after_update_object_path_for(@suggestion)
      else
        render :new
      end
    else
      if @suggestion.valid?
        cache_pending_object(@suggestion)
        redirect_to preview_path(class_name: 'suggestion')
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @suggestion.update(suggestion_params)
      flash[:success] = object_flash_message_for(@suggestion)
      redirect_to after_update_object_path_for(@suggestion)
    else
      render :edit
    end
  end

  def destroy
    @suggestion.destroy
    flash[:success] = object_flash_message_for(@suggestion)
    redirect_to after_update_object_path_for(@suggestion)
  end

  def like
    if user_signed_in?
      @suggestion.liked_by(current_user, vote_scope: 'rating', vote_weight: params[:vote_weight])
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@suggestion) }
        format.js
      end
    else
      cache_pending_like(@suggestion, { vote_scope: 'rating', vote_weight: params[:vote_weight] })
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def unlike
    @suggestion.unliked_by(current_user, vote_scope: 'rating', vote_weight: params[:vote_weight])

    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@suggestion) }
      format.js
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:title, :description, :link)
  end

  def load_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def authorize_user!
    unless @suggestion.user == current_user
      flash[:danger] = I18n.t('controllers.suggestions.flash.danger')
      redirect_to after_update_object_path_for(@suggestion)
    end
  end
end
