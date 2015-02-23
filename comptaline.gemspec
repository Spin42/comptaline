# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "comptaline/version"

Gem::Specification.new do |spec|
  spec.name          = "comptaline"
  spec.version       = Comptaline::VERSION
  spec.authors       = ["Spin42"]
  spec.email         = ["info@spin42.com"]
  spec.summary       = "Client gem for Comptaline API"
  spec.description   = "Client gem for Comptaline API"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency             "rest-client", "~> 1.7"
  spec.add_dependency             "nori", "~> 2.4.0"
end
