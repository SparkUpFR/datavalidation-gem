# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_validation/version'

Gem::Specification.new do |spec|
  spec.name          = "data_validation"
  spec.version       = DataValidation::VERSION
  spec.authors       = ["Maxime Bacoux"]
  spec.email         = ["max@bacoux.com"]

  spec.summary       = %q{A ruby interface over the DataValidation service.}
  spec.homepage      = "https://github.com/SparkUpFR/datavalidation-gem"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "httparty", "~> 0.14"
end
