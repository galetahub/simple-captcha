module SimpleCaptcha #:nodoc
  module ModelHelpers #:nodoc
    def self.included(base)
      base.extend(SingletonMethods)
    end

    # To implement model based simple captcha use this method in the model as...
    #
    #  class User < ActiveRecord::Base
    #
    #    apply_simple_captcha :message => "my customized message"
    #
    #  end
    #
    # Customize the error message by using :message, the default message is "Captcha did not match".
    # As in the applications captcha is needed with a very few cases like signing up the new user, but
    # not every time you need to authenticate the captcha with @user.save. So as to maintain simplicity
    # here we have the explicit method to save the instace with captcha validation as...
    #
    # * to validate the instance
    #
    #  @user.valid_with_captcha?  # whene captcha validation is required.
    #
    #  @user.valid?               # when captcha validation is not required.
    #
    # * to save the instance
    #
    #  @user.save_with_captcha   # whene captcha validation is required.
    #
    #  @user.save                # when captcha validation is not required.
    module SingletonMethods
      def apply_simple_captcha(options = {})
        options = { :add_to_base => false }.merge(options)

        class_attribute :simple_captcha_options
        self.simple_captcha_options = options

        unless self.is_a?(ClassMethods)
          include InstanceMethods
          extend ClassMethods

          attr_accessor :captcha, :captcha_key
        end
      end
    end

    module ClassMethods
    end

    module InstanceMethods

      def valid_with_captcha?
        [valid?, is_captcha_valid?].all?
      end

      def is_captcha_valid?
        return true if SimpleCaptcha.always_pass

        if captcha && captcha.upcase.delete(" ") == SimpleCaptcha::Utils::simple_captcha_value(captcha_key)
          SimpleCaptcha::Utils::simple_captcha_passed!(captcha_key)
          return true
        else
          message = simple_captcha_options[:message] || I18n.t(self.class.model_name.to_s.downcase, :scope => [:simple_captcha, :message], :default => :default)
          simple_captcha_options[:add_to_base] ? errors.add(:base, message) : errors.add(:captcha, message)
          return false
        end
      end

      def save_with_captcha
        valid_with_captcha? && save(:validate => false)
      end
    end
  end
end
