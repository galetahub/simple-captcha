module SimpleCaptcha
  class CustomFormBuilder < Formtastic::FormBuilder

    private

    def simple_captcha_input(method, options)
      options.update :object => sanitized_object_name
      self.send(:show_simple_captcha, options)
    end
  end
end
