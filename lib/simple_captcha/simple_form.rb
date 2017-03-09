module SimpleCaptcha
  class CaptchaSimpleFormInput < SimpleForm::Inputs::Base
    def input
      "#{@builder.show_simple_captcha(:object => attribute_name)}".html_safe
    end
  end
end
