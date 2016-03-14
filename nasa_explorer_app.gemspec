# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nasa_explorer_app/version'

Gem::Specification.new do |spec|
  spec.name          = 'nasa_explorer_app'
  spec.version       = NasaExplorerApp::VERSION
  spec.authors       = ['Laith Shadeed']
  spec.email         = ['laith.shadeed@gmail.com']

  spec.summary       = 'Sample solution for NASA Explorer coding challenge'
  spec.description   = 'This is an OOP attempt for the challenge, it be solved
also in shorter functional way'
  spec.homepage      = 'https://github.com/laithshadeed/nasa-explorer-app'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
