# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uatu/version'

Gem::Specification.new do |spec|
  spec.name          = "uatu-marvel"
  spec.version       = Uatu::VERSION
  spec.authors       = ["Víctor Martín"]
  spec.email         = ["victor.martin84@gmail.com"]
  spec.summary       = %q{Marvel API Wrapper}
  spec.description   = %q{Lightweight Marvel API Wrapper for Ruby.}
  spec.homepage      = "https://github.com/eltercero/uatu"
  spec.license       = "MIT"

  spec.files      = `git ls-files -z`.split("\x0")
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency 'faraday', '~>0.9'
  spec.add_development_dependency 'json', '~>1.8'
  spec.add_development_dependency 'hashie', '~>2.0'
  spec.add_development_dependency 'activesupport', '~> 4.1', '>= 4.1.11'

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", '~> 3.1', '>= 3.1.1'
  spec.add_development_dependency "sinatra", '~> 2.0', '>= 2.0.0'
end
