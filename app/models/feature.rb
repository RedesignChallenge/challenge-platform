# == Schema Information
#
# Table name: features
#
#  id               :integer          not null, primary key
#  reason           :text
#  category         :string
#  active           :boolean
#  user_id          :integer
#  featureable_id   :integer
#  featureable_type :string
#  created_at       :datetime
#  updated_at       :datetime
#  challenge_id     :integer          not null
#

class Feature < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :featureable, polymorphic: true

  before_validation :validate_panelist

  after_save { self.featureable.update_column(:featured, self.active) }

  private
  def validate_panelist
    if self.user
      unless featureable.challenge.panelists.exists?(user.id)
        self.errors[:user] = "#{self.user.name} is not a panelist for \"#{featureable.challenge.title}\", so they cannot mark this content as featured."
      end
    end
  end
end
