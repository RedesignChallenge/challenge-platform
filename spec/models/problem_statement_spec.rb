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

require 'rails_helper'

describe ProblemStatement do

  it { is_expected.to belong_to(:idea_stage) }
  it { is_expected.to have_many(:ideas) }

end
