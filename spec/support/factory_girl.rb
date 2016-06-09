RSpec.configure do |config|
  config.include FactoryGirl::Syntax::methods

  FactoryGirl.allow_class_lookup = false

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end