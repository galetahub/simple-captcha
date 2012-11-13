module SimpleCaptcha
  module FormBuilder
    def self.included(base)
      base.send(:include, SimpleCaptcha::ViewHelper)
      base.send(:include, SimpleCaptcha::FormBuilder::ClassMethods)
      base.send(:include, ActionView::Helpers)
      base.send(:include, Sprockets::Helpers::RailsHelper)
      base.send(:include, Sprockets::Helpers::IsolatedHelper)
      
      base.delegate :render, :session, :to => :template
    end
    
    module ClassMethods
      # Example:
		  # <% form_for :post, :url => posts_path do |form| %>
		  #   ...
		  #   <%= form.simple_captcha :label => "Enter numbers.." %>
		  # <% end %>
		  #
		  def simple_captcha(options = {})
      	options.update :object => @object_name
      	show_simple_captcha(objectify_options(options))
      end
      
      private
        
        def template
          @template
        end
        
        def simple_captcha_field(options={})
          text_field(:captcha, :value => '', :autocomplete => 'off') +
          hidden_field(:captcha_key, {:value => options[:field_value]})
        end
    end
  end
end
