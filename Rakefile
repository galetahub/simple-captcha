begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SimpleCaptcha'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
if File.exists? APP_RAKEFILE
  load 'rails/tasks/engine.rake'
end

namespace :dummy do
  desc 'Setup dummy Rails app for test purpose'
  task :setup do
    require 'rails'
    require 'simple_captcha'
    require File.expand_path('../test/lib/generators/simple_captcha/dummy/dummy_generator', __FILE__)
    SimpleCaptcha::DummyGenerator.start %w(--quiet)
  end

  desc 'destroy dummy Rails app under test/dummy'
  task :destroy do
    FileUtils.rm_rf "test/dummy" if File.exists?("test/dummy")
  end

end




Bundler::GemHelper.install_tasks :name => 'simple_captcha2'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task default: :test

