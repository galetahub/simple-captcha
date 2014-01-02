# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_captcha/version"

Gem::Specification.new do |s|
  s.name = "simple_captcha2"
  s.version = SimpleCaptcha::VERSION.dup
  s.platform = Gem::Platform::RUBY
  s.summary = "SimpleCaptcha is the simplest and a robust captcha plugin."
  s.description = "SimpleCaptcha is available to be used with Rails 3 + 4 or above and also it provides the backward compatibility with previous versions of Rails."
  s.authors = ["Pavlo Galeta", "Igor Galeta", 'Stefan Wienert']
  s.email = "stwienert@gmail.com"
  s.homepage = "http://github.com/pludoni/simple-captcha"

  s.files = Dir["{lib}/**/*"] + ["Rakefile", "README.md"]
  s.extra_rdoc_files = ["README.md"]
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '>= 3.1'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "capybara-mechanize"
  s.add_development_dependency "pry"

end
