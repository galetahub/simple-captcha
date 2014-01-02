source "https://rubygems.org"

gemspec :name => 'simple_captcha2'

gem 'sqlite3'
gem 'rails', ENV['RAILS'] || '~> 4.0'

if ENV['DB'] and ENV['DB']['mysql']
  gem 'mysql2'
end

if ENV['FORMTASTIC']
  gem 'formtastic', ENV['FORMTASTIC']
end
