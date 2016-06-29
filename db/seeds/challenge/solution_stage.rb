challenge = Challenge.find(1)
challenge.update_column(:active_stage, 'solution')

## CREATING SOLUTION STAGE
solution_stage = challenge.create_solution_stage!(
  title: 'Your ideas in action!',
  description: 'See the video solutions in action. Get inspired and keep the momentum going.',
  active: true,
  public: true,
  starts_at: 30.days.from_now,
  ends_at: 45.days.from_now
)

## CREATING SOLUTIONS
solution_story_titles = ['How Lakeside High Used Classroom Blooper Videos to Foster a Peer Coaching Culture', 'How Darrington High Made their Library of PD Videos Relevant', 'How PS292 Used Skype for Online Classroom Observation and Coaching', 'How Angela Stuart used Artisanal Classroom Confessionals Before they Sold Out']

embeds = ['https://youtube.com/watch?v=rzfhs3M4lus', 'https://vimeo.com/82083297', nil]

images = %w(http://www.uglydogbooks.com/wp-content/uploads/2014/04/books.jpg https://c4.staticflickr.com/4/3553/3421529389_005faf57a5_b.jpg)

solution_story_titles.each do |solution_story_title|
  solution_stage.solution_stories.create!(
    title: solution_story_title,
    description: Faker::Lorem.paragraph(15),
    remote_image_url: images.sample,
    link: embeds.sample
  )
end