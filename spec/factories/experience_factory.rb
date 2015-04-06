# == Schema Information
#
# Table name: experiences
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  image                   :string
#  link                    :text
#  featured                :boolean
#  top_comment             :boolean
#  user_id                 :integer
#  theme_id                :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  embed                   :text
#  destroyed_at            :datetime
#

FactoryGirl.define do
  factory :experience, class: Experience do
    description 'This is a default description from FactoryGirl.'
  end
end

