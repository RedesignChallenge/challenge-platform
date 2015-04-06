module CommentsHelper

  def comment_placeholder_for(comment)
    case comment.commentable.class.to_s.downcase
    when 'approachidea'
      "Want to try this idea but not sure how? What do you think could be improved or changed about this idea?"
    else
      "What do you think about this #{comment.commentable.class.to_s.downcase}? Suggest an improvement, explain how you think this #{comment.commentable.class.to_s.downcase} could be implemented, or provide other feedback."
    end
  end
end
