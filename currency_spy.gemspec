# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "currency_spy/version"

Gem::Specification.new do |s|
  s.name        = "currency_spy"
  s.version     = CurrencySpy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lukasz Badura"]
  s.email       = ["lukasz@niebo.net"]
  s.homepage    = "http://rubygems.org/gems/currency_spy"
  s.summary     = %q{A gem to fetch currency rates.}
  s.description = %q{A simple gem to parse and fetch currency rates from different websites.}

  s.rubyforge_project = "currency_spy"

  s.add_development_dependency "rspec"
  s.add_dependency "mechanize"
  s.add_dependency "bundler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
