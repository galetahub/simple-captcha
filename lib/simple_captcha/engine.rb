# encoding: utf-8
require 'rails'
require 'simple_captcha'

module SimpleCaptcha
  class Engine < ::Rails::Engine
    config.before_initialize do
      case SimpleCaptcha.store
        when 'active_record'
          require 'simple_captcha/active_record'
          require 'simple_captcha/simple_captcha_data'

          ActiveSupport.on_load :active_record do
            ActiveRecord::Base.send(:include, SimpleCaptcha::ModelHelpers)
          end
        when 'mongoid'
          require 'simple_captcha/simple_captcha_data_mongoid.rb'
        when 'mongomapper'
          require 'simple_captcha/simple_captcha_data_mongomapper.rb'
        when 'redis'
          require 'simple_captcha/simple_captcha_data_redis.rb'
        else
          raise StandardError.new("Unknown store: #{SimpleCaptcha.store}")
      end
    end

    config.after_initialize do

      ActionView::Base.send(:include, SimpleCaptcha::ViewHelper)
      ActionView::Helpers::FormBuilder.send(:include, SimpleCaptcha::FormBuilder)

      if Object.const_defined?("Formtastic")
        if Formtastic.const_defined?("Helpers")
          Formtastic::Helpers::FormHelper.builder = SimpleCaptcha::CustomFormBuilder
        else
          Formtastic::SemanticFormHelper.builder = SimpleCaptcha::CustomFormBuilder
        end
      end
    end

    config.app_middleware.use SimpleCaptcha::Middleware
  end
end


