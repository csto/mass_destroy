require 'active_record'
require 'pry'
require 'mass_destroy'
require 'factory_girl'
require 'database_cleaner'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'mass_destroy'
)

load File.dirname(__FILE__) + '/schema.rb'
require File.dirname(__FILE__) + '/models.rb'
require File.dirname(__FILE__) + '/factories.rb'


RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
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
    ActiveRecord::Base.logger = nil
    DatabaseCleaner.clean
  end
  
  config.around(:example) do |example|
    ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)
    example.run
    ActiveRecord::Base.logger = nil
  end
end
