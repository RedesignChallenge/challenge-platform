challenge = Challenge.find(1)
challenge.update_column(:active_stage, 'recipe')

## CREATING RECIPE STAGE
recipe_stage = challenge.create_recipe_stage!(
  title: "Let's make these ideas work!",
  description: "You shared ideas in Stage 2, now let's make these work in the real world. Share how you would try an idea in your school.",
  incentive: '',
  active: true,
  public: true,
  starts_at: 10.days.from_now,
  ends_at: 15.days.from_now
)

## CREATING RECIPE IDEAS
cookbook_titles = ['Using Classroom Bloopers to Facilitate Open Discussion', 'Standards-Aligned Video Library', 'Online Video Coaching and Help']

links = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://vimeo.com/82083297', 'http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg', 'https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg', nil]

cookbook_titles.each do |cookbook_title|
  cookbook = recipe_stage.cookbooks.create!(
    title: cookbook_title,
    description: Faker::Lorem.paragraph(4)
  )

  ## Creating comment threads for those ideas
  1+rand(8).times do |n|
    comment = Comment.build_from(
      cookbook,
      (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
      { body: Faker::Lorem.sentence, link: links.sample }
    )
    comment.save!

    ## Nested comment
    nested = Comment.create!(
      commentable: cookbook,
      user: User.find((User.pluck(:id) - challenge.panelists.pluck(:id)).sample),
      body: 'Nested: ' + Faker::Lorem.sentence,
      link: links.sample,
      temporal_parent_id: comment.id
    ) if [true, false].sample

    # Add featured comments for every multiple of 3.
    if n % 3 == 0
      Feature.create!(user_id: challenge.panelists.pluck(:id).sample, featureable: comment, challenge: challenge, active: true, reason: Faker::Hacker.say_something_smart)
    end
  end
end