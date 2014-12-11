$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "action_mailer_tls/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "action_mailer_tls"
  s.version     = ActionMailerTls::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActionMailerTls."
  s.description = "TODO: Description of ActionMailerTls."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"

  s.add_development_dependency "sqlite3"
end
