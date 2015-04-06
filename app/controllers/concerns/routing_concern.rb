module RoutingConcern
  extend ActiveSupport::Concern
  
  ## DEVISE ROUTING
  def after_sign_in_path_for(resource)
    persist_pending_cache
    complete_profile_request
    super
  end

  ## OBJECT PERSISTENCE ROUTING
  def after_update_object_path_for(object)
    case object.class.to_s.downcase
    when 'experience'
      if object.paranoia_destroyed?
        challenge_experience_stage_path(object.challenge, object.experience_stage)
      else
        challenge_experience_stage_theme_experience_path(object.challenge, object.experience_stage, object.theme, object)
      end
    when 'idea'
      if object.paranoia_destroyed?
        challenge_idea_stage_path(object.challenge, object.idea_stage)
      else
        challenge_idea_stage_problem_statement_idea_path(object.challenge, object.idea_stage, object.problem_statement, object)
      end
    when 'approach'
      if object.paranoia_destroyed?
        challenge_approach_stage_path(object.challenge, object.approach_stage)
      else
        challenge_approach_stage_approach_idea_approach_path(object.challenge, object.approach_stage, object.approach_idea, object)
      end
    when 'approachidea'
      challenge_approach_stage_approach_idea_path(object.challenge, object.approach_stage, object)
    when 'solutionstory'
      challenge_solution_stage_solution_story_path(object.challenge, object.solution_stage, object)
    when 'solution'
      challenge_solution_stage_solution_story_path(object.challenge, object.solution_stage, object.solution_story)
    when 'comment'
      after_update_object_path_for(object.commentable)
    when 'suggestion'
      root_path
    else
      root_path
    end
  rescue
    root_path
  end

private

  def complete_profile_request
    flash[:notice] += " Please <a href='#{edit_user_registration_url(setting: 'onboard')}'>complete your profile</a>." if resource.sign_in_count < 5 && !resource.profile_complete?
  rescue
  end

end