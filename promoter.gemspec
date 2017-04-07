# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'promoter/version'

Gem::Specification.new do |spec|
  spec.name          = "promoter"
  spec.version       = Promoter::VERSION
  spec.authors       = ["Lachlan Priest"]
  spec.email         = ["lachlan@advocate.ly"]

  spec.summary       = "Micro gem for Promoter API"
  spec.description   = "Micro gem for Promoter API to pull NPS results"
  spec.homepage      = "https://github.com/advocately/promoter-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "multi_json"
  spec.add_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
end
