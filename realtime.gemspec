$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "realtime/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "realtime"
  s.version     = Realtime::VERSION
  s.authors     = ["Mike Atlas"]
  s.email       = ["mike.atlas@gmail.com"]
  s.homepage    = "http://mikeatlas.github.io/realtime-rails/"
  s.summary     = "Realtime support for Rails applications."
  s.description = "Provides a simple Realtime framework for Rails applications."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"
  s.add_dependency "redis"

end
