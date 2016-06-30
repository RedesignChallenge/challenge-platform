# == Schema Information
#
# Table name: recipe_stages
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

class RecipeStage < ActiveRecord::Base
  belongs_to :challenge
  has_many :cookbooks
  has_many :recipes, through: :cookbooks
end
