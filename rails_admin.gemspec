$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "rails_admin_content"
  s.version = RailsAdmin::VERSION
  s.authors = ["Lijia Tong"]
  s.email = ["wtuyuupe@163.com"]
  s.homepage = "http://github.com/tonglijia/rails_admin"
  s.summary = "Can be used in the development process, often a tool to modify the database contents"
  s.description = "Content Management Database Development Environment"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.13"
  s.add_dependency "jquery-rails"
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'slim'
  s.add_dependency 'mysql2'


end