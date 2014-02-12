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

  spec.add_development_dependency 'faraday', '~>0.9.0'
  spec.add_development_dependency 'minitest', '~>5.2.2'
  spec.add_development_dependency 'json', '~>1.8.1'
  spec.add_development_dependency 'hashie', '~>2.0.5'
  spec.add_development_dependency 'pry', '~>0.9.12.6'
  spec.add_development_dependency 'activesupport', '~>3.2.16'
end
