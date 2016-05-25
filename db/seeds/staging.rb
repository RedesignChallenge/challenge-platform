## IMPORTING ALL CSV DATA
require_relative 'imports/states.rb'
require_relative 'imports/districts.rb'
require_relative 'imports/schools.rb'

## SEEDING USERS
require_relative 'users/admins.rb'
require_relative 'users/participants.rb'

## SUGGESTION DATA
require_relative 'other/suggestions.rb'

## CHALLENGE DATA
require_relative 'challenge/challenge.rb'
require_relative 'challenge/experience_stage.rb'
require_relative 'challenge/experiences.rb'
require_relative 'challenge/idea_stage.rb'
require_relative 'challenge/ideas.rb'
require_relative 'challenge/recipe_stage.rb'
require_relative 'challenge/recipes.rb'
require_relative 'challenge/solution_stage.rb'
require_relative 'challenge/solutions.rb'