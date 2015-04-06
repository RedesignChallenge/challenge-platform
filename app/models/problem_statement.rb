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

class ProblemStatement < ActiveRecord::Base
  belongs_to :idea_stage
  has_many :ideas
end
