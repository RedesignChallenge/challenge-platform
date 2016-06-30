namespace :db do
  desc 'Drop, create, migrate then seed the database'
  task recreate: :environment do
    Rake::Task['log:clear'].invoke
    Rake::Task['tmp:clear'].invoke
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Sidekiq::Queue.new.clear
    Sidekiq::RetrySet.new.clear
  end
end