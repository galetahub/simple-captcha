# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_captcha/version"

Gem::Specification.new do |s|
  s.name = "galetahub-simple_captcha"
  s.version = SimpleCaptcha::VERSION.dup
  s.platform = Gem::Platform::RUBY
  s.summary = "SimpleCaptcha is the simplest and a robust captcha plugin."
  s.description = "SimpleCaptcha is available to be used with Rails 3 or above and also it provides the backward compatibility with previous versions of Rails."
  s.authors = ["Pavlo Galeta", "Igor Galeta"]
  s.email = "galeta.igor@gmail.com"
  s.homepage = "https://github.com/galetahub/simple-captcha"

  s.files = Dir["{lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["{test}/**/*"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.require_paths = ["lib"]
end
