module SimpleCaptcha
  module FormtasticFormBuilder
    def self.included(base)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      include SimpleCaptcha::ViewHelper

      def simple_captcha_input(method, options)
        options.update :object => sanitized_object_name
        self.send(:show_simple_captcha, options)
      end
    end
  end
end
