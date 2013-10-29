# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'light/version'

Gem::Specification.new do |spec|
  spec.name          = "light"
  spec.version       = Light::VERSION
  spec.authors       = ["Pawel Niemczyk"]
  spec.email         = ["pniemczyk@o2.pl"]
  spec.description   = %q{Light models}
  spec.summary       = %q{Light models}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
