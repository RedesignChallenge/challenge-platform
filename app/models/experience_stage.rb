# == Schema Information
#
# Table name: experience_stages
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  active       :boolean
#  public       :boolean
#  starts_at    :datetime
#  ends_at      :datetime
#  challenge_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  incentive    :text
#

class ExperienceStage < ActiveRecord::Base
  belongs_to :challenge
  has_many :themes
  has_many :experiences, through: :themes
end
