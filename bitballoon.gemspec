# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitballoon/version'

Gem::Specification.new do |gem|
  gem.name          = "bitballoon"
  gem.version       = BitBalloon::VERSION
  gem.authors       = ["Mathias Biilmann Christensen"]
  gem.email         = ["mathias@bitballoon.com"]
  gem.description   = %q{API Client for BitBalloon}
  gem.summary       = %q{API Client for BitBalloon}
  gem.homepage      = "https://www.bitballoon.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "oauth2", ">=  0.9.2"
  gem.add_dependency "slop"
  gem.add_dependency "highline"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "webmock"
end