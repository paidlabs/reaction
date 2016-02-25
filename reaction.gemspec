# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'reaction'
  gem.version       = '0.0.0'
  gem.authors       = ["Jonathan Calhoun"]
  gem.email         = ["joncalhoun@gmail.com"]
  gem.description   = 'Reaction is a library to help build reusable actions for Rails controllers.'
  gem.summary       = 'Reaction is a library to help build reusable actions for Rails controllers.'
  gem.homepage      = 'https://github.com/joncalhoun/reaction'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
