# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'couch_crud/version'

Gem::Specification.new do |spec|
  spec.name          = "couch_crud"
  spec.version       = CouchCrud::VERSION
  spec.authors       = ["Iain Gray"]
  spec.email         = ["support@quantdeck.com"]
  spec.summary       = %q{Mixin to provide basic CRUD operations for CouchDB}
  spec.description   = %q{couch_crud provides a minimal, simple Couchdb CRUD layer using couchrest}
  spec.homepage      = "https://github.com/quantdeck/couch_crud"
  spec.license       = "Apache"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "contracts", "~> 0.6"
  spec.add_runtime_dependency "couchrest", "~> 1.2", ">= 1.2.0"

end
