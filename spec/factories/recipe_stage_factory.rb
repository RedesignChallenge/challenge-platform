# == Schema Information
#
# Table name: recipe_stages
#
#  id                       :integer          not null, primary key
#  title                    :string
#  description              :text
#  active                   :boolean
#  public                   :boolean
#  starts_at                :datetime
#  ends_at                  :datetime
#  challenge_id             :integer
#  created_at               :datetime
#  updated_at               :datetime
#  incentive                :text
#  title_instructions       :text             default("Add a Title")
#  description_instructions :text             default("Describe your recipe. What are the goals? What are the challenges? Why does this recipe matter?")
#  steps_instructions       :text             default("Outline how to implement this recipe step by step.")
#  materials_instructions   :text             default("What equipment or supplies are needed?")
#  community_instructions   :text             default("Every good recipe provides the number of servings. How many people need to participate and who are they?")
#  conditions_instructions  :text             default("What needs to be true of the culture or environment to try out this recipe?")
#  evidence_instructions    :text             default("What evidence can we collect to know when we’re on the right track?")
#  protips_instructions     :text             default("What advice can you offer to make the experience of trying out your recipe as smooth as possible?  Is there anything you can identify as a possible stumbling block? Things to keep in mind?")
#

FactoryGirl.define do
  factory :recipe_stage, class: RecipeStage do
    title 'This is a sample title from FactoryGirl.'
    description 'This is a sample description from FactoryGirl.'
  end
end
