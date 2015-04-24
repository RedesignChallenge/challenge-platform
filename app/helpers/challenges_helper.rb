module ChallengesHelper

  # CHALLENGE ACTIVE STAGE ROUTING
  # def challenge_active_stage_path(challenge)
  #   case challenge.active_stage.downcase
  #   when 'experience'
  #     challenge_experience_stage_path(challenge, challenge.experience_stage)
  #   when 'idea'
  #     challenge_idea_stage_path(challenge, challenge.idea_stage)
  #   when 'approach'
  #     challenge_approach_stage_path(challenge, challenge.approach_stage)
  #   when 'solution'
  #     challenge_solution_stage_path(challenge, challenge.solution_stage)
  #   else
  #     challenge_path(challenge)
  #   end
  # end

  def challenge_nav_margin(challenge)
    case challenge.active_stage.downcase
    when 'experience'
      'margin: 0.25em 3.525em'
    when 'idea'
      'margin: 0.25em 2.85em'
    when 'approach'
      'margin: 0.25em 2.175em'
    when 'solution'
      'margin: 0.25em 1.5em'
    else
      'margin: 0.25em 1.5em'
    end    
  end

end