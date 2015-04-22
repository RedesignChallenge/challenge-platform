challenge = Challenge.find(1)

links = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://vimeo.com/82083297', 'http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg', 'https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg', nil]

## CREATING APPROACHES
challenge.approach_stage.approach_ideas.each do |approach_idea|
  5.times do
    approach = approach_idea.approaches.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      needs: Faker::Lorem.paragraph,
      user_id: (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
      link: links.sample,
      published_at: Time.now
    )

    1+rand(5).times do |index|
      approach.steps.create!(
        display_order: 1 + index,
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph
      )
    end

    ## Creating comment threads for those approaches
    max_comments = 1+rand(8)
    max_comments.times do |n|
      comment = Comment.build_from(
        approach,
        (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
        {body: Faker::Lorem.sentence, link: links.sample}
      )
      comment.save!

      ## Nested comment
      nested = Comment.create!(
        commentable: approach,
        user: User.find((User.pluck(:id) - challenge.panelists.pluck(:id)).sample),
        body: 'Nested: ' + Faker::Lorem.sentence,
        link: links.sample,
        temporal_parent_id: comment.id
      ) if [true, false].sample
    end
  end
end

challenge.approach_stage.approach_ideas.each do |approach_idea|
  feature = Feature.create!(
    user_id: challenge.panelists.pluck(:id).sample,
    featured: approach_idea.approaches.sample,
    active: true,
    reason: Faker::Hacker.say_something_smart
  )
end