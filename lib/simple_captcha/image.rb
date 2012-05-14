require 'tempfile'
module SimpleCaptcha #:nodoc
  module ImageHelpers #:nodoc

    IMAGE_STYLES = [
      'embosed_silver',
      'simply_red',
      'simply_green',
      'simply_blue',
      'distorted_black',
      'all_black',
      'charcoal_grey',
      'almost_invisible'
    ]

    DISTORTIONS = ['low', 'medium', 'high']

    class << self
      
      def image_style(key='simply_blue')
        return IMAGE_STYLES[rand(IMAGE_STYLES.length)] if key=='random'
        IMAGE_STYLES.include?(key) ? key : 'simply_blue'
      end

      def distortion(key='low')
        key =
          key == 'random' ?
          DISTORTIONS[rand(DISTORTIONS.length)] :
          DISTORTIONS.include?(key) ? key : 'low'
        case key.to_s
          when 'low' then return [0 + rand(2), 80 + rand(20)]
          when 'medium' then return [2 + rand(2), 50 + rand(20)]
          when 'high' then return [4 + rand(2), 30 + rand(20)]
        end
      end
    end

    private
    
      def append_simple_captcha_code #:nodoc      
        color = @simple_captcha_image_options[:color]
        text = Magick::Draw.new
        text.annotate(@image, 0, 0, 0, 5, Utils::simple_captcha_value(@simple_captcha_image_options[:simple_captcha_key])) do
          self.font_family = 'arial'
          self.pointsize = 22
          self.fill = color
          self.gravity = Magick::CenterGravity
        end
      end

      def set_simple_captcha_image_style #:nodoc
        amplitude, frequency = @simple_captcha_image_options[:distortion]
        case @simple_captcha_image_options[:image_style]
        when 'embosed_silver'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency).shade(true, 20, 60)
        when 'simply_red'
          @simple_captcha_image_options[:color] = 'darkred'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency)
        when 'simply_green'
          @simple_captcha_image_options[:color] = 'darkgreen'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency)
        when 'simply_blue'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency)
        when 'distorted_black'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency).edge(10)
        when 'all_black'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency).edge(2)
        when 'charcoal_grey'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency).charcoal
        when 'almost_invisible'
          @simple_captcha_image_options[:color] = 'red'
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency).solarize
        else
          append_simple_captcha_code
          @image = @image.wave(amplitude, frequency)
        end
      end

      def generate_simple_captcha_image(simple_captcha_key)  #:nodoc
        @image = Magick::Image.new(110, 30) do 
          self.background_color = 'white'
          self.format = 'JPG'
        end
        @simple_captcha_image_options = {
          :simple_captcha_key => simple_captcha_key,
          :color => 'darkblue',
          :distortion => SimpleCaptcha::ImageHelpers.distortion(SimpleCaptcha.distortion),
          :image_style => SimpleCaptcha::ImageHelpers.image_style(SimpleCaptcha.image_style).dup
        }
        set_simple_captcha_image_style      
        @image.implode(0.2).to_blob
      end
  end
end
