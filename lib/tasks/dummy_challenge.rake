namespace :db do
  desc "Create dummy challenge"
  task dummy_challenge: :environment do
    require_relative '../../db/seeds/challenge.rb'
  end
end