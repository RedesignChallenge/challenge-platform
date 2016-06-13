# == Schema Information
#
# Table name: recipes
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  materials               :text
#  link                    :text
#  image                   :string
#  file                    :text
#  embed                   :text
#  destroyed_at            :datetime
#  cookbook_id             :integer
#  user_id                 :integer
#  refinement_parent_id    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  published_at            :datetime
#  comments_count          :integer          default(0)
#  featured                :boolean          default(FALSE)
#  community               :text
#  conditions              :text
#  evidence                :text
#  protips                 :text
#

class Recipe < ActiveRecord::Base
  include Embeddable
  include URLNormalizer
  include Publishable
  include Orderable

  belongs_to :cookbook
  belongs_to :user
  has_many :steps, as: :steppable
  has_one :feature, as: :featureable
  has_many :refinements, class_name: 'Recipe', foreign_key: 'refinement_parent_id'
  belongs_to :refinement_parent, class_name: 'Recipe'
  has_and_belongs_to_many :solutions

  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: lambda { |step| step['description'].blank? }

  acts_as_votable
  acts_as_commentable
  acts_as_paranoid column: :destroyed_at

  validates :title, presence: true
  validates :description, presence: true
  validates :link, url: true, allow_blank: true

  def recipe_stage
    self.cookbook.recipe_stage
  end

  def challenge
    self.recipe_stage.challenge
  end

  def default_like
    DEFAULT_LIKE
  end

  def icon
    'fa-flask'
  end
end
