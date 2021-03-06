class CommentMailerPreview < ActionMailer::Preview
  
  def replied
    CommentMailer.replied(Comment.where('parent_id IS NOT NULL').first.id)
  end
  
  def posted
    CommentMailer.posted(Comment.first.id)
  end

  def followed
    CommentMailer.followed(Comment.first.id, User.first.id)
  end

end