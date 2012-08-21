module SimpleCaptcha #:nodoc 
  module ControllerHelpers #:nodoc
    # This method is to validate the simple captcha in controller.
    # It means when the captcha is controller based i.e. :object has not been passed to the method show_simple_captcha.
    #
    # *Example*
    #
    # If you want to save an object say @user only if the captcha is validated then do like this in action...
    #
    #  if simple_captcha_valid?
    #   @user.save
    #  else
    #   flash[:notice] = "captcha did not match"
    #   redirect_to :action => "myaction"
    #  end
    def simple_captcha_valid?
      return true if Rails.env.test?
      
      if params[:captcha]
        data = SimpleCaptcha::Utils::simple_captcha_value(params[:captcha_key] || session[:captcha])
        result = data == params[:captcha].delete(" ").upcase
        SimpleCaptcha::Utils::simple_captcha_passed!(session[:captcha]) if result
        return result
      else
        return false
      end
    end
  end
end
