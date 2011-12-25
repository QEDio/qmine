# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "qmine/version"

Gem::Specification.new do |s|
  s.name        = "qmine"
  s.version     = Qmine::VERSION
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "qmine"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rake'
  
  s.add_development_dependency 'turn'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'spork'
  s.add_development_dependency 'spork-testunit'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'i18n'
end
