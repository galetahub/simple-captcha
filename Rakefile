require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the simple_captcha plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the simple_captcha plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SimpleCaptcha'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "simple_captcha"
    gemspec.version = '0.1.1'
    gemspec.summary = "SimpleCaptcha is the simplest and a robust captcha plugin."
    gemspec.description = "SimpleCaptcha is available to be used with Rails 3 or above and also it provides the backward compatibility with previous versions of Rails."
    gemspec.email = "superp1987@gmail.com"
    gemspec.homepage = "http://github.com/galetahub/simple-captcha"
    gemspec.authors = ["Pavlo Galeta", "Igor Galeta"]
    gemspec.files = FileList["[A-Z]*", "{lib}/**/*", "{app}/**/*", "{config}/**/*", "{test}/**/*"]
    gemspec.rubyforge_project = "simple_captcha"
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
