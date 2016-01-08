$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'mass_destroy/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'mass_destroy'
  s.version     = MassDestroy::VERSION
  s.authors     = ['Corey']
  s.email       = ['coreystout@gmail.com']
  s.homepage    = 'http://github.com/csto/mass_destroy'
  s.summary     = "Mass Destroy provides a quicker, N+1 free alternative for destroying records and all dependent records in Active Record."
  s.description = "Mass Destroy provides a quicker, N+1 free alternative for destroying records and all dependent records in Active Record.  It works by finding all associations and deleting them in one query, versus one query for each record and association.  For instance, if a user has 50 albums with 100 photos each, MassDestroy will delete the user, the user's albums and the user's photos all with 3 queries or less."
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']
  
  s.required_ruby_version = '>= 1.9.2'
  
  s.add_dependency 'activerecord', '>= 4.2.0'
  s.add_dependency 'activesupport', '>= 4.2.0'
  
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rails'
end
