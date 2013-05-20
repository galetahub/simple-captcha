module SimpleCaptcha
  class CustomFormBuilder < (defined?(::Formtastic::FormBuilder) ? Formtastic::FormBuilder : ::Formtastic::SemanticFormBuilder)

    private

    def simple_captcha_input(method, options)
      options.update :object => sanitized_object_name
      self.send(:show_simple_captcha, options)
    end
  end
end
