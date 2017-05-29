# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tacit/version"

Gem::Specification.new do |spec|
  spec.name          = "tacit"
  spec.version       = Tacit::VERSION
  spec.authors       = ["Ritchie Paul Buitre"]
  spec.email         = ["ritchie@richorelse.com"]

  spec.summary       = %q{Collection of ruby refinements to reduce lines of code.}
  spec.description   = %q{Refinements providing glue methods for inheritance chaining.}
  spec.homepage      = "https://github.com/RichOrElse/tacit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
