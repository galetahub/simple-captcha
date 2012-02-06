module SimpleCaptcha
  class CustomFormBuilder < CUSTOM_FORM_BASE_CLASS

    private

    def simple_captcha_input(method, options)
      options.update :object => sanitized_object_name
      self.send(:show_simple_captcha, options)
    end
  end
end
