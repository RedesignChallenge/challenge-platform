# == Schema Information
#
# Table name: comments
#
#  id                      :integer          not null, primary key
#  commentable_id          :integer
#  commentable_type        :string
#  body                    :text
#  user_id                 :integer          not null
#  parent_id               :integer
#  lft                     :integer
#  rgt                     :integer
#  reported                :boolean          default(FALSE), not null
#  created_at              :datetime
#  updated_at              :datetime
#  embed                   :text
#  link                    :text
#  temporal_parent_id      :integer
#  destroyed_at            :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#

class Comment < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  acts_as_votable
  acts_as_nested_set scope: [:commentable_id, :commentable_type]
  acts_as_paranoid column: :destroyed_at

  after_create do
    if self.temporal_parent_id.present?
      parent_comment = Comment.find_by(id: self.temporal_parent_id)
      self.move_to_child_of(parent_comment) if parent_comment
    end
  end
  
  validates :body, presence: true
  validates :link, url: true, allow_blank: true

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, comment)
    new \
      commentable: obj,
      user_id: user_id,
      body: comment[:body],
      link: comment[:link]
  end

  # Helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  def has_parent?
    self.parent_id.present?
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user| where(user_id: user.id).order(created_at: :desc) }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable,
        lambda { |commentable_str, commentable_id|
          where(commentable_type: commentable_str.to_s, commentable_id: commentable_id).order(created_at: :desc)
        }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  def default_like
    DEFAULT_LIKE
  end

end
