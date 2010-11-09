module SimpleCaptcha
  class SimpleCaptchaData < ::ActiveRecord::Base
    set_table_name "simple_captcha_data"
    
    attr_accessible :key, :value
    
    class << self
      def get_data(key)
        data = find_by_key(key) || new(:key => key)
      end
      
      def remove_data(key)
        delete_all(["#{connection.quote_column_name(:key)} = ?", key])
        clear_old_data(1.hour.ago)
      end
      
      def clear_old_data(time = 1.hour.ago)
        return unless Time === time
        delete_all(["#{connection.quote_column_name(:updated_at)} < ?", time])
      end
    end
  end
end
