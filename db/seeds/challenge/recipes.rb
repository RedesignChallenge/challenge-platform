challenge = Challenge.find(1)

links = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://vimeo.com/82083297', 'http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg', 'https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg', nil]

## CREATING RECIPES
challenge.recipe_stage.cookbooks.each do |cookbook|
  5.times do
    recipe = cookbook.recipes.create!(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      materials: Faker::Lorem.paragraph,
      community: Faker::Lorem.paragraph,
      conditions: Faker::Lorem.paragraph,
      evidence: Faker::Lorem.paragraph,
      protips: Faker::Lorem.paragraph,
      user_id: (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
      link: links.sample,
      published_at: Time.now
    )

    1+rand(5).times do |index|
      recipe.steps.create!(
        display_order: 1 + index,
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph
      )
    end

    ## Creating comment threads for those recipes
    max_comments = 1+rand(8)
    max_comments.times do |n|
      comment = Comment.build_from(
        recipe,
        User.pluck(:id).sample,
        {body: Faker::Lorem.sentence, link: links.sample}
      )
      comment.save!

      ## Nested comment
      nested = Comment.create!(
        commentable: recipe,
        user: User.find(User.pluck(:id).sample),
        body: 'Nested: ' + Faker::Lorem.sentence,
        link: links.sample,
        temporal_parent_id: comment.id
      ) if [true, false].sample
    end
  end

  feature = Feature.create!(
    user_id: challenge.panelists.pluck(:id).sample,
    featureable: cookbook.recipes.sample,
    active: true,
    challenge: challenge,
    reason: Faker::Hacker.say_something_smart
  )
end