class CommentsController < ApplicationController
  before_action :authenticate_user!,  except: [:new, :create, :like]
  before_action :load_comment,        only:   [:edit, :update, :destroy, :like, :unlike]
  before_action :authorize_user!,     only:   [:edit, :update, :destroy]

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    if user_signed_in?
      @comment.user = current_user
      if @comment.save
        flash[:success] = object_flash_message_for(@comment)
        @comment.send_notifications unless Rails.env.development?
        redirect_to after_update_object_path_for(@comment)
      else
        render :new
      end
    else
      if @comment.valid?
        cache_pending_object(@comment)
        redirect_to preview_path(class_name: 'comment')
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = object_flash_message_for(@comment)
      redirect_to after_update_object_path_for(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = object_flash_message_for(@comment)
    redirect_to after_update_object_path_for(@comment)
  end

  def like
    if user_signed_in?
      @comment.liked_by(current_user, vote_scope: @comment.default_like[:scope])
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@comment) }
        format.js   { render :like, locals: { partial: "#{params[:partial]}" } }
      end
    else
      cache_pending_like(@comment, {vote_scope: @comment.default_like[:scope]})
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def unlike
    @comment.unliked_by(current_user, vote_scope: @comment.default_like[:scope])

    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@comment) }
      format.js   { render :unlike, locals: { partial: "#{params[:partial]}" } }
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :link, :temporal_parent_id, :commentable_type, :commentable_id)
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user!
    unless @comment.user == current_user
      flash[:danger] = 'You do not have access to that area or operation.'
      redirect_to after_update_object_path_for(@comment)
    end
  end

end