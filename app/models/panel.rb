# == Schema Information
#
# Table name: panels
#
#  id           :integer          not null, primary key
#  about        :text
#  challenge_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Panel < ActiveRecord::Base
  belongs_to :challenge
  has_and_belongs_to_many :users 
  
end
