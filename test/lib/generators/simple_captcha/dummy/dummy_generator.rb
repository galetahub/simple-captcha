require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

# stolen from https://github.com/radar/forem/blob/master/spec/lib/generators/forem/dummy/dummy_generator.rb
module SimpleCaptcha
  class DummyGenerator < Rails::Generators::Base
    desc "Creates dummy test Rails application"

    def self.source_paths
      paths = self.superclass.source_paths
      paths << File.expand_path('../templates', __FILE__)
      paths.flatten
    end

    PASSTHROUGH_OPTIONS = [
      :skip_active_record, :skip_javascript, :database, :javascript, :quiet, :pretend, :force, :skip
    ]

    def generate_test_dummy
      opts = (options || {}).slice(*PASSTHROUGH_OPTIONS) || {} # rails 3.2 ? -> slice is nil
      opts[:force] = true
      opts[:skip_bundle] = true
      opts[:old_style_hash] = true

      invoke Rails::Generators::AppGenerator, [ File.expand_path(dummy_path, destination_root) ], opts
      run "rails generate simple_captcha"
    end

    def test_dummy_clean
      inside dummy_path do
        remove_file ".gitignore"
        remove_file "doc"
        remove_file "Gemfile"
        remove_file "lib/tasks"
        remove_file "app"
        remove_file "public/index.html"
        remove_file "public/robots.txt"
        remove_file "README"
        remove_file "test"
        remove_file "vendor"
      end
    end

    def test_dummy_config
      directory "app", "#{dummy_path}/app"
      copy_file "config/database.yml", "#{dummy_path}/config/database.yml", :force => true
      template "config/routes.rb", "#{dummy_path}/config/routes.rb", :force => true
      copy_file "config/boot.rb", "#{dummy_path}/config/boot.rb", :force => true
    end

    protected

    def dummy_path
      'test/dummy'
    end

    def module_name
      'Dummy'
    end

    def application_definition
      @application_definition ||= begin
                                    dummy_application_path = File.expand_path("#{dummy_path}/config/application.rb", destination_root)
                                    unless options[:pretend] || !File.exists?(dummy_application_path)
                                      contents = File.read(dummy_application_path)
                                      contents[(contents.index("module #{module_name}"))..-1]
                                    end
                                  end
    end
    alias :store_application_definition! :application_definition

    def gemfile_path
      '../../../../Gemfile'
    end
  end
end
