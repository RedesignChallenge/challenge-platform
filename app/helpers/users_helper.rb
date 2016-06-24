module UsersHelper

  ROLES = {
    I18n.t('helpers.users.roles.pre_service_teacher_key') => 'Pre-Service Teacher',
    I18n.t('helpers.users.roles.current_teacher_key') => 'Current Teacher',
    I18n.t('helpers.users.roles.teacher_leader_key') => 'Teacher Leader',
    I18n.t('helpers.users.roles.instructional_coach_key') => 'Instructional Coach',
    I18n.t('helpers.users.roles.school_leader_key') => 'School Leader',
    I18n.t('helpers.users.roles.district_staff_key') => 'LEA Staff',
    I18n.t('helpers.users.roles.state_staff_key') => 'SEA Staff',
    I18n.t('helpers.users.roles.other_key') => 'Other'
  }

  def display_commenters(entity)
    render_users(entity.comment_threads.map(&:user).map(&:display_name).uniq)
  end

  def display_likers(entity)
    render_users(entity.votes_for.voters.map(&:display_name))
  end

  def submissions(profile_user, viewing_user)
    viewing_user = nil unless viewing_user == profile_user
    (
    profile_user.experiences.published(viewing_user) +
      profile_user.ideas.published(viewing_user) +
      profile_user.recipes.published(viewing_user) +
      profile_user.solutions.published(viewing_user) +
      profile_user.suggestions(viewing_user)
    ).sort_by(&:created_at).reverse
  end

  protected

  def render_users(names)
    visible_name_size = 2
    if names.size <= visible_name_size
      names.to_sentence
    else
      remainder = names.size - visible_name_size
      I18n.t('users.cards._submission.pluralized_name_list',
             names: names.first(visible_name_size).join(', '),
             remainder: pluralize(remainder, I18n.t('users.cards._submission.other')))
    end
  end
end
