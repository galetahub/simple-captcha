if defined? Formtastic
  require 'formtastic/version'
  if Formtastic::VERSION < '2.2'
    raise 'Only Formtastic Version 2.2 or greater is supported by SimpleCaptcha'
  end

  class SimpleCaptchaInput
    include Formtastic::Inputs::Base
    def to_html
      options.update :object => sanitized_object_name
      builder.send(:show_simple_captcha, options)
    end
  end

end
