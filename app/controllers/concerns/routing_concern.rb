module RoutingConcern
  extend ActiveSupport::Concern

  ## DEVISE ROUTING
  def after_sign_in_path_for(resource)
    persist_pending_cache
    complete_profile_request
    super
  end

  ## OBJECT PERSISTENCE ROUTING
  def after_update_object_path_for(object, options = {})
    case object.class.to_s.downcase
    when 'experience'
      if object.paranoia_destroyed?
        challenge_experience_stage_path(object.challenge, object.experience_stage)
      else
        challenge_experience_stage_theme_experience_path(object.challenge, object.experience_stage, object.theme, object, anchor: options[:anchor], temporal_parent_id: options[:temporal_parent_id])
      end
    when 'idea'
      if object.paranoia_destroyed?
        challenge_idea_stage_path(object.challenge, object.idea_stage)
      else
        challenge_idea_stage_problem_statement_idea_path(object.challenge, object.idea_stage, object.problem_statement, object, anchor: options[:anchor], temporal_parent_id: options[:temporal_parent_id])
      end
    when 'recipe'
      if object.paranoia_destroyed?
        challenge_recipe_stage_path(object.challenge, object.recipe_stage)
      else
        challenge_recipe_stage_cookbook_recipe_path(object.challenge, object.recipe_stage, object.cookbook, object, anchor: options[:anchor], temporal_parent_id: options[:temporal_parent_id])
      end
    when 'cookbook'
      challenge_recipe_stage_cookbook_path(object.challenge, object.recipe_stage, object)
    when 'solutionstory'
      challenge_solution_stage_solution_story_path(object.challenge, object.solution_stage, object, anchor: options[:anchor], temporal_parent_id: options[:temporal_parent_id])
    when 'solution'
      challenge_solution_stage_solution_story_path(object.challenge, object.solution_stage, object.solution_story, anchor: options[:anchor], temporal_parent_id: options[:temporal_parent_id])
    when 'comment'
      after_update_object_path_for(object.commentable, options)
    when 'suggestion'
      root_path(anchor: options[:anchor])
    else
      root_path
    end
  rescue
    root_path
  end

  ## OBJECT PERSISTENCE ROUTING
  def after_update_object_url_for(object, options = {})
    path_to_url(after_update_object_path_for(object, options))
  rescue
    root_url
  end

  def path_to_url(path)
    "#{ENV['SITE_PROTOCOL']}://#{ENV['SITE_HOST']}#{path}"
  end

private

  def complete_profile_request
    flash[:notice] += I18n.t('concerns.routing.flash.notice', url: edit_user_registration_url(setting: 'onboard')) if resource.sign_in_count < 5 && !resource.profile_complete?
  rescue
  end

end