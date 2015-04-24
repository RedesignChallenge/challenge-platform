challenge = Challenge.find(1)
# challenge.update_column(:active_stage, 'approach')

## CREATING APPROACH STAGE
approach_stage = challenge.create_approach_stage!(title: "Let's make these ideas work!",
                                                  description: "You shared ideas in Stage 2, now let's uncover how to make these work in the real world. When you share how you would try it you can win a gift card! People who suggest the best approaches are eligible for a trip to Startup Weekend in July to try them out!",
                                                  incentive: 'Win a gift card when you participate! The best approaches go to Startup Weekend!',
                                                  active: true,
                                                  public: true,
                                                  starts_at: 5.days.from_now,
                                                  ends_at: 10.days.from_now)

## CREATING APPROACH IDEAS
approach_idea_titles = ['Using Classroom Bloopers to Facilitate Open Discussion', 'Standards-Aligned Video Library', 'Online Video Coaching and Help']

links = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://vimeo.com/82083297', 'http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg', 'https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg', nil]

approach_idea_titles.each do |approach_idea_title|
  approach_idea = approach_stage.approach_ideas.create!(
    title: approach_idea_title,
    description: Faker::Lorem.paragraph(4),
    idea_id: Idea.pluck(:id).sample
  )

  ## Creating comment threads for those ideas
  1+rand(8).times do |n|
    comment = Comment.build_from(
      approach_idea,
      (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
      { body: Faker::Lorem.sentence, link: links.sample }
    )
    comment.save!

    ## Nested comment
    nested = Comment.create!(
      commentable: approach_idea,
      user: User.find((User.pluck(:id) - challenge.panelists.pluck(:id)).sample),
      body: 'Nested: ' + Faker::Lorem.sentence,
      link: links.sample,
      temporal_parent_id: comment.id
    ) if [true, false].sample

    # Add featured comments for every multiple of 3.
    if n % 3 == 0
      Feature.create!(user_id: challenge.panelists.pluck(:id).sample, featured: comment, active: true, reason: Faker::Hacker.say_something_smart)
    end
  end
end