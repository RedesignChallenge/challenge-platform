# == Schema Information
#
# Table name: solutions
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  needs                   :text
#  effort                  :string
#  link                    :text
#  embed                   :text
#  image                   :string
#  file                    :string
#  destroyed_at            :datetime
#  solution_story_id       :integer
#  user_id                 :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#

FactoryGirl.define do
  factory :solution, class: Solution do
    title 'This is a solution title from FactoryGirl.'
    description 'This is a solution from FactoryGirl.'
  end
end
