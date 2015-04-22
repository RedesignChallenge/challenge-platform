 
# == Schema Information
#
# Table name: solution_stories
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  link              :text
#  embed             :text
#  image             :string
#  destroyed_at      :datetime
#  solution_stage_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

FactoryGirl.define do
  factory :solution_story, class: SolutionStory do
    title 'This is a solution story title from FactoryGirl.'
    description 'This is a solution story from FactoryGirl.'
  end


end
