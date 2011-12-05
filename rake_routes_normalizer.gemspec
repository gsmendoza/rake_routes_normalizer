# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rake_routes_normalizer/version"

Gem::Specification.new do |s|
  s.name        = "rake_routes_normalizer"
  s.version     = RakeRoutesNormalizer::VERSION
  s.authors     = ["George Mendoza"]
  s.email       = ["gsmendoza@gmail.com"]
  s.homepage    = ""
  s.summary     = "Normalize the printout of rake routes so that it's easier to diff"
  s.description = %q{
    rake_routes_normalizer is a utility for migrating routes from Rails 2 to 3. It can
    normalize the printout of rake routes so that it's easier to diff Rails 2 to 3 routes.
  }

  s.rubyforge_project = "rake_routes_normalizer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency "minitest"
  s.add_development_dependency "ruby-debug"

  s.add_runtime_dependency "thor"
end
