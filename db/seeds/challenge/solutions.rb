challenge = Challenge.find(1)

links = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://vimeo.com/82083297', 'http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg', 'https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg', nil]

efforts = %w(hours days weeks months)

## CREATING GUIDES
challenge.solution_stage.solution_stories.each do |solution_story|

  solution = solution_story.create_solution!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph(10),
    materials: Faker::Lorem.paragraph(5),
    effort: efforts.sample,
    link: links.sample,
    experience_ids:  Experience.pluck(:id).sample(4),
    idea_ids:  Idea.pluck(:id).sample(2),
    recipe_ids:  Recipe.pluck(:id).sample,
    user_id: (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
    published_at: Time.now
  )

  1+rand(5).times do |index|
    solution.steps.create!(
      display_order: 1 + index,
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph
    )
  end

  ## Creating comment threads for those guides
  1+rand(8).times do
    comment = Comment.build_from(
      solution,
      User.pluck(:id).sample,
      { body: Faker::Lorem.sentence, link: links.sample }
    )
    comment.save!

    ## Nested comment
    nested = Comment.create!(
      commentable: solution,
      user: User.find(User.pluck(:id).sample),
      body: 'Nested: ' + Faker::Lorem.sentence,
      link: links.sample,
      temporal_parent_id: comment.id
    ) if [true, false].sample
  end
    
end

feature = Feature.create!(
  user_id: challenge.panelists.pluck(:id).sample,
  featureable: challenge.solution_stage.solutions.sample,
  active: true,
  challenge: challenge,
  reason: Faker::Hacker.say_something_smart
)