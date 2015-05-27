# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prawn/chart/version'

Gem::Specification.new do |spec|
  spec.name          = 'prawn-chart'
  spec.version       = Prawn::Chart::VERSION
  spec.authors       = ['Claudio Baccigalupo']
  spec.email         = ['claudio@fullscreen.net']
  spec.summary       = %q{Adds the `chart` method to Prawn.}
  spec.description   = %q{A library to easily draw graphs in PDF files.}
  spec.homepage      = 'http://github.com/Fullscreen/prawn-chart'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'prawn', '~> 2.0'
  spec.add_dependency 'activesupport' # 3 or 4, see gemfiles/
  spec.add_dependency 'actionview' # NOTE: This won't work with Rails 3

  # For development / Code coverage / Documentation
  spec.add_development_dependency 'pdf-inspector', '~> 1.2.0'
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'coveralls', '~> 0.8.0'
end