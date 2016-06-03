module UsersHelper

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