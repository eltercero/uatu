# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uatu/version'

Gem::Specification.new do |spec|
  spec.name          = "Uatu"
  spec.version       = Uatu::VERSION
  spec.authors       = ["Victor"]
  spec.email         = ["victor.martin84@gmail.com"]
  spec.summary       = %q{Marvel API Wrapper}
  spec.description   = %q{Marvel API Wrapper}
  spec.homepage      = "https://github.com/eltercero/uatu"
  spec.license       = "MIT"

  spec.files      = `git ls-files -z`.split("\x0")
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'faraday'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'hashie'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'activesupport'
end
