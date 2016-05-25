# == Schema Information
#
# Table name: suggestions
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  link                    :text
#  embed                   :text
#  image                   :string
#  destroyed_at            :datetime
#  user_id                 :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#

class Suggestion < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  default_scope { order(cached_votes_total: :desc, created_at: :desc, id: :desc) }

  belongs_to :user
  acts_as_votable
  acts_as_paranoid column: :destroyed_at

  validates :title,       presence: true
  validates :description, presence: true
  validates :link,        url: true, allow_blank: true

  RATING_WEIGHTS = [1,2,3,4]

  def icon
    'fa-archive'
  end
  
end
