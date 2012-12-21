# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'empezar/version'

Gem::Specification.new do |gem|
  gem.name          = "empezar"
  gem.version       = Empezar::VERSION
  gem.authors       = ["Xavier Via"]
  gem.email         = ["xavierviacanel@gmail.com"]
  gem.description   = %q{A simple Ruby library to enforce a convention for configuration, logging and execution}
  gem.summary       = %q{A simple Ruby library to enforce a convention for configuration, logging and execution}
  gem.homepage      = "http://github.com/Fetcher/empezar"

  gem.add_dependency 'symbolmatrix'
  gem.add_dependency 'discoverer'
  gem.add_dependency 'term-ansicolor'
  gem.add_dependency 'fast'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fast'
  gem.add_development_dependency 'cucumber'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
