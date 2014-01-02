require 'simple_captcha'
if Rails.version > '4.0'
  class User
    include ActiveModel::Model
    include SimpleCaptcha::ModelHelpers
    apply_simple_captcha
  end
else
  class User
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    include SimpleCaptcha::ModelHelpers
    include ActiveModel::MassAssignmentSecurity
    apply_simple_captcha
    attr_accessible :key
    def persisted?; false; end
    def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
    end
  end
end
