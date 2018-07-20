# -*- encoding: utf-8 -*-
# frozen_string_literal: true
Gem::Specification.new do |gem|
  gem.name    = "shoperb_liquid"
  gem.version = "0.0.1"

  gem.authors  = ["Myroslava Stavnycha"]
  gem.email    = ["myroslava@perfectline.co"]
  gem.summary  = "shoperb_liquid is a liquid drops, tags and filters for Shoperb"
  gem.homepage = "http://www.shoperb.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib", "liquid/lib"]

  gem.add_dependency "liquid", ">= 4.0.0"
  gem.add_dependency "activesupport"
  gem.add_dependency "actionpack"
  gem.add_dependency "kaminari"
  gem.add_dependency "i18n"
  gem.add_dependency "request_store"
end
