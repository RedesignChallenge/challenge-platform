# == Schema Information
#
# Table name: approaches
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  needs                   :text
#  link                    :text
#  image                   :string
#  file                    :text
#  embed                   :text
#  destroyed_at            :datetime
#  approach_idea_id        :integer
#  user_id                 :integer
#  refinement_parent_id    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  published_at            :datetime
#

FactoryGirl.define do
  factory :approach, class: Approach do
    title 'This is an approach title from FactoryGirl.'
    description 'This is a approach from FactoryGirl.'
  end

  trait :with_sequential_steps do
    after :create do |approach|
      approach.steps = FactoryGirl.create_list(:step, 6, :with_order)
    end
  end
end
