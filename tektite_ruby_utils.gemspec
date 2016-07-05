# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tektite_ruby_utils/version'

Gem::Specification.new do |spec|
  spec.name          = 'tektite_ruby_utils'
  spec.version       = TektiteRubyUtils::VERSION
  spec.authors       = ['Tektite Software', 'Xavier Bick']
  spec.email         = ['fxb9500@gmail.com']

  spec.summary       = 'Extensions and utilities for Ruby'
  spec.description   = 'Adds additional functionality to Ruby,
                       such as PresentClass (opposite of NilClass).'
  spec.homepage      = 'https://github.com/tektite-software/ruby_utils'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`
               .split("\x0")
               .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
