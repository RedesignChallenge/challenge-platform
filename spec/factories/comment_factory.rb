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

FactoryGirl.define do
  factory :comment, class: Comment do
    user
    body 'This is a test comment from FactoryGirl.'
  end
end

