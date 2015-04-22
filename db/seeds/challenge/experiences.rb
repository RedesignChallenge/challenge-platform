challenge = Challenge.find(1)

links = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://twitter.com/MrBronke/status/559780396225662977', 'https://vimeo.com/82083297', 'http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg', 'https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg', nil]

## CREATING DEMO EXPERIENCES
15.times do
  experience = Experience.create!(
    description: Faker::Lorem.paragraph,
    user_id: (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
    theme_id: challenge.experience_stage.themes.pluck(:id).sample,
    link: links.sample,
    published_at: Time.now
  )

  ## Creating comment threads for those ideas
  1+rand(8).times do
    comment = Comment.build_from(
      experience,
      (User.pluck(:id) - challenge.panelists.pluck(:id)).sample,
      { body: Faker::Lorem.sentence, link: links.sample }
    )
    comment.save!

    ## Nested comment
    nested = Comment.create!(
      commentable: experience,
      user: User.find((User.pluck(:id) - challenge.panelists.pluck(:id)).sample),
      body: 'Nested: ' + Faker::Lorem.sentence,
      link: links.sample,
      temporal_parent_id: comment.id
    ) if [true, false].sample
  end
end