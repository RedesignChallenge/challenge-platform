# == Schema Information
#
# Table name: problem_statements
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :text
#  idea_stage_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :problem_statement, class: ProblemStatement do
  end
end
