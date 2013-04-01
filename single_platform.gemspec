# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'single_platform/version'

Gem::Specification.new do |spec|
  spec.name          = "single_platform"
  spec.version       = SinglePlatform::VERSION
  spec.authors       = ["Justin Ricaurte"]
  spec.email         = ["justin@justinricaurte.com"]
  spec.description   = %q{A simple way to get data from the Single Platform api.}
  spec.summary       = %q{A simple way to get data from the Single Platform api.}
  spec.homepage      = "https://github.com/ricaurte/single_platform"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "faraday", "~> 0.8"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "active_support", "~> 3.0"
end
