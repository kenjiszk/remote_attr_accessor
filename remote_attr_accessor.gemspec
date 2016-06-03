$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "remote_attr_accessor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "remote_attr_accessor"
  s.version     = RemoteAttrAccessor::VERSION
  s.authors     = ["kenji.suzuki"]
  s.email       = ["kenji.suzuki.1984@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of RemoteAttrAccessor."
  s.description = "Description of RemoteAttrAccessor."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "rspec"
end
