# == Schema Information
#
# Table name: challenges
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  hashtag      :string
#  slug         :string
#  video_url    :string
#  ends_at      :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  background   :text
#  outcome      :text
#  help         :text
#  image        :string
#  starts_at    :datetime
#  active_stage :string
#  headline     :string
#  incentive    :text
#  cta          :string
#  banner       :string
#  featured     :boolean
#

class Challenge < ActiveRecord::Base
  extend FriendlyId
  include ActiveRecord::QueryMethods
  friendly_id :title, use: [:slugged, :finders]
  rails_admin do
    configure :slug do
      read_only true
    end
  end

  has_one :panel
  has_one :experience_stage
  has_one :idea_stage
  has_one :recipe_stage
  has_one :solution_stage

  mount_uploader :banner, ImageUploader
  process_in_background :banner

  def self.featured
    where(featured: true).where('starts_at < ?', Time.now).where('ends_at > ?', Time.now).first
  end

  def panelists
    self.panel.users
  end

  def featured_contributions
    case self.active_stage
      when 'experience'
        self.experience_stage.experiences.published.first(2)
      when 'idea'
        self.idea_stage.ideas.published.where(inspiration: false).first(3)
      when 'recipe'
        self.recipe_stage.recipes.published.first(2)
      when 'solution'
        self.solution_stage.solutions.first(2)
      else
        nil
    end
  end

  def has_featured_for(type)
    Feature.exists?(featureable_type: type, active: true, challenge_id: self.id)
  end

  def stage_number
    case self.active_stage
      when 'experience'
        1
      when 'idea'
        2
      when 'recipe'
        3
      when 'solution'
        4
      else
        1
    end
  end

  STAGES = [
    {
      number: 1,
      name: 'experience',
      action: 'shared',
      icon: 'fa-comment',
      headline: -> { I18n.t('experience_stages.headline') },
      description: -> { I18n.t('experience_stages.description') }
    },
    {
      number: 2,
      name: 'idea',
      action: 'contributed',
      icon: 'fa-lightbulb-o',
      headline: -> { I18n.t('idea_stages.headline') },
      description: -> { I18n.t('idea_stages.description') }
    },
    {
      number: 3,
      name: 'recipe',
      action: 'developed',
      icon: 'fa-flask',
      headline: -> { I18n.t('recipe_stages.headline') },
      description: -> { I18n.t('recipe_stages.description') }
    },
    {
      number: 4,
      name: 'solution',
      action: 'tried',
      icon: 'fa-puzzle-piece',
      headline: -> { I18n.t('solution_stages.headline') },
      description: -> { I18n.t('solution_stages.description') }
    }
  ]
end
