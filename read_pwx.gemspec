# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'read_pwx/version'

Gem::Specification.new do |spec|
  spec.name          = "read_pwx"
  spec.version       = ReadPWX::VERSION
  spec.authors       = ["James Badger"]
  spec.email         = ["james@jamesbadger.ca"]
  spec.summary       = %q{Read PWX files}
  spec.description   = %q{Read PWX files for conversion to other data structures.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
