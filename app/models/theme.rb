# == Schema Information
#
# Table name: themes
#
#  id                  :integer          not null, primary key
#  title               :string
#  description         :text
#  experience_stage_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Theme < ActiveRecord::Base
  belongs_to :experience_stage
  has_many :experiences 
end
