module ChallengesHelper

  # CHALLENGE ACTIVE STAGE ROUTING
  def challenge_active_stage_path(challenge)
    case challenge.active_stage.downcase
      when 'experience'
        challenge_experience_stage_path(challenge, challenge.experience_stage)
      when 'idea'
        challenge_idea_stage_path(challenge, challenge.idea_stage)
      when 'recipe'
        challenge_recipe_stage_path(challenge, challenge.recipe_stage)
      when 'solution'
        challenge_solution_stage_path(challenge, challenge.solution_stage)
      else
        challenge_path(challenge)
    end
  end

  def challenge_nav_margin(challenge)
    case challenge.active_stage.downcase
      when 'experience'
        'margin: 0.25em 3.525em'
      when 'idea'
        'margin: 0.25em 2.85em'
      when 'recipe'
        'margin: 0.25em 2.175em'
      when 'solution'
        'margin: 0.25em 1.5em'
      else
        'margin: 0.25em 1.5em'
    end
  end

  def time_left(stage)
    if stage.ends_at
      remaining = stage.ends_at - Time.now

      if remaining/1.day >= 2
        number = (remaining/1.day).floor
        unit = I18n.t('challenges.helper.days')
      elsif remaining/1.hour >= 2
        number = (remaining/1.hour).floor
        unit = I18n.t('challenges.helper.hours')
      elsif remaining/1.minute > 1
        number = (remaining/1.minute).floor
        unit = I18n.t('challenges.helper.minutes')
      else
        number = 0
        unit = I18n.t('challenges.helper.days')
      end

      time = I18n.t('challenges.helper.time_left', number: number, unit: unit)
    else
      time = ''
    end

    time.html_safe
  end
end
