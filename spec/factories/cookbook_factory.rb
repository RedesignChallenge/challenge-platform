# == Schema Information
#
# Table name: cookbooks
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :text
#  recipe_stage_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#  comments_count  :integer          default(0)
#

FactoryGirl.define do
  factory :cookbook, class: Cookbook do
    sequence(:title) { |n| "Title ##{n}"}
    sequence(:description) { |n| "Description ##{n}"}
  end

  trait 'with_recipes' do

    transient do
      user nil
      amount 1
    end

    after :create do |cookbook, evaluator|
      cookbook.recipes = FactoryGirl.create_list(:recipe, evaluator.amount, user: evaluator.user)
    end
  end
end
