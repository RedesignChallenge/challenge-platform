# == Schema Information
#
# Table name: recipes
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  materials               :text
#  link                    :text
#  image                   :string
#  file                    :text
#  embed                   :text
#  destroyed_at            :datetime
#  cookbook_id             :integer
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
#  comments_count          :integer          default(0)
#  featured                :boolean          default(FALSE)
#  community               :text
#  conditions              :text
#  evidence                :text
#  protips                 :text
#

FactoryGirl.define do
  factory :recipe, class: Recipe do
    title 'This is an recipe title from FactoryGirl.'
    description 'This is a recipe from FactoryGirl.'
  end

  trait :with_sequential_steps do
    after :create do |recipe|
      recipe.steps = FactoryGirl.create_list(:step, 6, :with_order)
    end
  end
end
