module ChallengesHelper

  # CHALLENGE ACTIVE STAGE ROUTING
  def challenge_active_stage_path(challenge)
    case challenge.active_stage.downcase
    when 'experience'
      challenge_experience_stage_path(challenge, challenge.experience_stage)
    when 'idea'
      challenge_idea_stage_path(challenge, challenge.idea_stage)
    when 'approach'
      challenge_approach_stage_path(challenge, challenge.approach_stage)
    when 'solution'
      challenge_solution_stage_path(challenge, challenge.solution_stage)
    else
      challenge_path(challenge)
    end
  end

end