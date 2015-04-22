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
  friendly_id :title, use: [:slugged, :finders]
  rails_admin do
    configure :slug do
      read_only true
    end
  end

  has_one :panel
  has_one :experience_stage
  has_one :idea_stage
  has_one :approach_stage
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
    if self.active_stage == 'experience'
      self.experience_stage.experiences.published.reorder(cached_votes_up: :desc).first(2)
    elsif self.active_stage == 'idea'
      self.idea_stage.ideas.published.reorder(cached_votes_up: :desc).first(3)
    elsif self.active_stage == 'approach'
      self.approach_stage.published.approaches.reorder(cached_votes_up: :desc).first(2)
    elsif self.active_stage == 'solution'
      self.solution_stage.solutions.reorder(cached_votes_up: :desc).first(2)
    end
  end

  def stage_number
    case self.active_stage
    when 'experience'
      1
    when 'idea'
      2
    when 'approach'
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
      headline: 'Share Experiences',
      description: 'Tell others about problems that have affected you as an educator.'
    },
    {
      number: 2,
      name: 'idea',
      action: 'contributed',
      icon: 'fa-lightbulb-o',
      headline: 'Contribute Ideas',
      description: 'Contribute and compare ideas you might use to solve these problems.'
    },
    {
      number: 3,
      name: 'approach',
      action: 'developed',
      icon: 'fa-flask',
      headline: 'Develop Approaches',
      description: 'Develop and propose different approaches to tackling these problems.'
    },
    {
      number: 4,
      name: 'solution',
      action: 'tried',
      icon: 'fa-puzzle-piece',
      headline: 'Explore Real Stories',
      description: 'See stories of how real schools have adopted the solutions you’ve inspired, or try them out yourself!'
    }
  ]
end
