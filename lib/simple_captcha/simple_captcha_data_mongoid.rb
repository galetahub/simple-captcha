module SimpleCaptcha
  class SimpleCaptchaData
    include Mongoid::Document
    include Mongoid::Timestamps

    field :key, type: String
    field :value, type: String

    class << self
      def get_data(key)
        data = where(:key => key).first || new(:key => key)
      end
      
      def remove_data(key)
        where(:key => key).delete_all
        clear_old_data(1.hour.ago)
      end
      
      def clear_old_data(time = 1.hour.ago)
        return unless Time === time
        where(:updated_at.lte => time).delete_all
      end
    end
  end
end
