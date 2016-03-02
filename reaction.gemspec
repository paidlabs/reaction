# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'reaction'
  gem.version       = '0.2.1'
  gem.authors       = ["Jon Calhoun", "Jon Calhoun", "Ryan Jackson"]
  gem.email         = ["joncalhoun@gmail.com", "jon@paidlabs.com", "ryan@paidlabs.com"]
  gem.description   = 'Reaction makes it easy to build reusable controller actions along with reusable validators and param type converters.'
  gem.summary       = 'Reusable controller actions and validators.'
  gem.homepage      = 'https://github.com/paidlabs/reaction'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
