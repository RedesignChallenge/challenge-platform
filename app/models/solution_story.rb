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

class SolutionStory < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  default_scope { order(created_at: :asc) }

  belongs_to :solution_stage
  has_one :solution

  acts_as_paranoid column: :destroyed_at

  mount_uploader :image, ImageUploader
  process_in_background :image

  def challenge
    self.solution_stage.challenge
  end
end
