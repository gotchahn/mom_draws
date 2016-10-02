RSpec.configure do |config|

  config.before(:suite) do
    # https://github.com/DatabaseCleaner/database_cleaner#additional-activerecord-options-for-truncation
    DatabaseCleaner.clean_with(:truncation) # pre_count: true
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
