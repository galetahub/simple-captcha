module SimpleCaptcha
  class CustomFormBuilder
    def self.included(base)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      include SimpleCaptha::ViewHelper

      def simple_captcha_input(method, options)
        options.update :object => sanitized_object_name
        self.send(:show_simple_captcha, options)
      end
    end
  end
end
