challenge = Challenge.find(1)
challenge.update_column(:active_stage, 'idea')

## CREATING IDEATION STAGE
idea_stage = challenge.create_idea_stage!(
  title: 'Contribute your ideas!',
  description: "Stage 1 of the #{I18n.t(:project_name)} asked educators to describe the challenges they face with professional learning video. The conversation surfaced several common themes. For example, educators say that videos often are outdated or don’t reflect best practices or \"real life\" interaction between teachers and students. Now it’s time to address these and other challenges! Join our colleagues to work collaboratively in Stage 2 to address these challenges.",
  active: true, 
  public: true, 
  starts_at: 5.days.from_now, 
  ends_at: 10.days.from_now
)

## CREATING PROBLEM STATEMENTS
ps_titles = ['How might we make professional development videos more relevant?', 'How might we make professional development videos easier to find?', 'How might we better represent reality with professional development videos?']

ps_titles.each do |ps_title|
  idea_stage.problem_statements.create!(
    title: ps_title,
    description: Faker::Lorem.paragraph(4)
  )
end