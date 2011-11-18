# encoding: utf-8
require 'rails'
require 'simple_captcha'

module SimpleCaptcha
  class Engine < ::Rails::Engine
    config.before_initialize do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, SimpleCaptcha::ModelHelpers)
      end
    end

    config.after_initialize do
      ActionView::Base.send(:include, SimpleCaptcha::ViewHelper)
      ActionView::Helpers::FormBuilder.send(:include, SimpleCaptcha::FormBuilder)

      if Object.const_defined?("Formtastic")
        Formtastic::Helpers::FormHelper.builder = SimpleCaptcha::CustomFormBuilder
      end
    end

    config.app_middleware.use SimpleCaptcha::Middleware
  end
end


