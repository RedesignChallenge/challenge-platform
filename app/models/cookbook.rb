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

class Cookbook < ActiveRecord::Base
  belongs_to :recipe_stage
  has_many :recipes
  acts_as_commentable

  def challenge
    self.recipe_stage.challenge
  end
end
