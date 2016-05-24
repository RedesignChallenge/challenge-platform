challenge = Challenge.find(1)

links = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://vimeo.com/82083297', 'http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg', 'https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg', nil]

## CREATING IDEAS
challenge.idea_stage.problem_statements.each do |problem_statement|
  15.times do
    idea = problem_statement.ideas.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      impact: Faker::Lorem.paragraph,
      implementation: Faker::Lorem.paragraph,
      user_id: (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
      link: links.sample,
      published_at: Time.now
    )


    ## Creating comment threads for those ideas
    1+rand(8).times do
      comment = Comment.build_from(
        idea,
        User.pluck(:id).sample,
        { body: Faker::Lorem.sentence, link: links.sample }
      )
      comment.save!

      ## Nested comment
      nested = Comment.create!(
        commentable: idea,
        user: User.find(User.pluck(:id).sample),
        body: 'Nested: ' + Faker::Lorem.sentence,
        link: links.sample,
        temporal_parent_id: comment.id
      ) if [true, false].sample
    end
  end

  ideas = problem_statement.ideas
  parents = ideas - ideas.sample(12)
  subparents = ideas - parents - ideas.sample(10)
  remainders = ideas - parents - subparents

  subparents.each do |subparent|
    subparent.update_column(:refinement_parent_id, parents.collect(&:id).sample)
  end

  remainders.each do |remainder|
    remainder.update_column(:refinement_parent_id, (parents+subparents).collect(&:id).sample) if remainder.id.odd?
  end

  feature = Feature.create!(
    user_id: challenge.panelists.pluck(:id).sample,
    featureable: problem_statement.ideas.sample,
    active: true,
    challenge: challenge,
    reason: Faker::Hacker.say_something_smart
  )
end