# == Schema Information
#
# Table name: features
#
#  id            :integer          not null, primary key
#  reason        :text
#  category      :string
#  active        :boolean
#  user_id       :integer
#  featured_id   :integer
#  featured_type :string
#  created_at    :datetime
#  updated_at    :datetime
#

class Feature < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :featured, polymorphic: true

  before_validation :validate_panelist

  private
  def validate_panelist
    if self.user
      unless featured.challenge.panelists.exists?(user.id)
        self.errors[:user] = "#{self.user.name} is not a panelist for \"#{featured.challenge.title}\", so they cannot mark this content as featured."
      end
    end
  end
end
