class CommentMailer < ApplicationMailer
  default template_path: "mailers/#{mailer_name.split('_')[0].downcase}"

  def replied(comment_id)
    @comment = Comment.find(comment_id)
    @resource = @comment.parent.user
    @subject = I18n.t('mailers.comment.replied.subject', user: @comment.user.display_name, commentable: @comment.commentable_type, commentable_title: @comment.commentable_title.truncate(30))
  end

  def posted(comment_id)
    @comment = Comment.find(comment_id)
    @resource = @comment.commentable.user
    @subject = I18n.t('mailers.comment.posted.subject', user: @comment.user.display_name, commentable: @comment.commentable_type, commentable_title: @comment.commentable_title.truncate(30))
  end

  def followed(comment_id, user_id)
    @comment = Comment.find(comment_id)
    @resource = User.find(user_id)
    @subject = I18n.t('mailers.comment.followed.subject', user: @comment.user.display_name, commentable: @comment.commentable_type, commentable_title: @comment.commentable_title.truncate(30))
  end
end
