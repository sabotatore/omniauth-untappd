# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-untappd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'

  gem.authors       = ["Vitali Kulikou"]
  gem.email         = ["sabotatore@gmail.com"]
  gem.description   = %q{Untappd OAuth2 Strategy for OmniAuth.}
  gem.summary       = %q{Untappd OAuth2 Strategy for OmniAuth.}
  gem.homepage      = "https://github.com/sabotatore/omniauth-untappd"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-untappd"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Untappd::VERSION

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.1.0'
  gem.add_runtime_dependency 'multi_json', '~> 1.0'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'simplecov-sublime-ruby-coverage'
  gem.add_development_dependency 'coveralls'
end
