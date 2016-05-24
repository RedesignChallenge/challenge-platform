# == Schema Information
#
# Table name: ideas
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  link                    :text
#  image                   :string
#  file                    :string
#  embed                   :text
#  problem_statement_id    :integer
#  user_id                 :integer
#  refinement_parent_id    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  destroyed_at            :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  impact                  :text
#  implementation          :text
#  published_at            :datetime
#  comments_count          :integer          default(0)
#  inspiration             :boolean          default(FALSE)
#  featured                :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :idea, class: Idea do
    
    title 'Test title'
    description 'Test description'
  end
end

