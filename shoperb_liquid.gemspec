# -*- encoding: utf-8 -*-
# frozen_string_literal: true
Gem::Specification.new do |gem|
  gem.name    = "shoperb_liquid"
  gem.version = "0.0.2"
  gem.required_ruby_version = ">= 3.2.0"

  gem.author    = ["Shoperb"]
  gem.email     = ["engineering@shoperb.com"]
  gem.summary   = "Custom Liquid drops, tags, and filters for building Shoperb themes."
  gem.homepage  = "https://shoperb.dev"
  gem.license   = "MIT"

  gem.files = Dir[
    "lib/**/*",
    "shoperb_liquid.gemspec",
    "Rakefile",
    "README*",
    "LICENSE*",
  ].select { |f| File.file?(f) }
  gem.require_paths = ["lib", "liquid/lib"]

  gem.metadata = {
    "rubygems_mfa_required" => "true",
    "homepage_uri"=> "https://www.shoperb.com",
    "documentation_uri"=> "https://shoperb.dev",
    "source_code_uri"  => "https://github.com/shoperb/theme-editor",
    "bug_tracker_uri"  => "https://github.com/shoperb/theme-editor/issues"
  }

  gem.add_dependency "liquid", ">= 4.0.0"
  gem.add_dependency "activesupport", "~> 7.1.2"
  gem.add_dependency "actionpack", "~> 7.1.2"
  gem.add_dependency "pagy", "~> 9.3.5"
  gem.add_dependency "i18n", "~> 1.14.0"
  gem.add_dependency "request_store", "~> 1.7.0"
end
