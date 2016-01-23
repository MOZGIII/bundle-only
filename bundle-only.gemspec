# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundle-only/version'

Gem::Specification.new do |spec|
  spec.name          = 'bundle-only'
  spec.version       = BundleOnly::VERSION
  spec.authors       = ['MOZGIII']
  spec.email         = ['mike-n@narod.ru']

  spec.summary       = 'Install gems from a specific Gemfile group.'
  spec.description   = <<-DESCRIPTION.gsub(/\A\s+/, '')
    This gem provides a bundle-only command that installs a set of gems listed
    in specified Gemfile group.
    Gems are always installed into the system and never update Gemfile.lock.
  DESCRIPTION
  spec.homepage      = 'https://github.com/MOZGIII/bundle-only'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '>= 0.36.0'
end
