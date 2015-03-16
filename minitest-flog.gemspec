# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/flog/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest-flog"
  spec.version       = Minitest::Flog::VERSION
  spec.authors       = ["Chris Kottom"]
  spec.email         = ["chris@chriskottom.com"]

  spec.summary       = %q{Flog integration for Minitest}
  spec.description   = %q{Uses Flog to test code complexity during testing}
  spec.homepage      = "https://github.com/chriskottom/minitest-flog"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "minitest", "~> 5.5"
  spec.add_dependency "flog", "~> 4.3"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
