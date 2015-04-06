# == Schema Information
#
# Table name: suggestions
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  link                    :text
#  embed                   :text
#  image                   :string
#  destroyed_at            :datetime
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
  factory :suggestion, class: Suggestion do
    title 'Test title'
    description 'This is a default description from FactoryGirl.'
  end
end

