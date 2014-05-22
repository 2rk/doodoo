# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doodoo/version'

Gem::Specification.new do |spec|
  spec.name          = "doodoo"
  spec.version       = Doodoo::VERSION
  spec.authors       = ["Matt Connolly"]
  spec.email         = ["matt.connolly@tworedkites.com"]
  spec.summary       = %q{A set of tools to help with CanCan.}
  spec.description   = <<EOF
A set of tools to help with CanCan.

Doodoo provides a module for use with Rails controllers that assists with authorisation,
especially with nested routes.
EOF
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 3.2'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
end
