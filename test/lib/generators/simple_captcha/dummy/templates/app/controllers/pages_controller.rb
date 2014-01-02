class PagesController < ApplicationController
  def form_tag
  end

  def form_tag_submit
    if simple_captcha_valid?
      render text: 'captcha valid!'
    else
      render text: 'captcha not valid!'
    end
  end

  def model_tag
    @user = User.new
  end

  def model_tag_submit
    @model = User.new(params[:user])
    if @model.valid_with_captcha?
      render text: 'captcha valid!'
    else
      render text: 'captcha not valid!'
    end
  end

  def formtastic_tag
    @user = User.new
  end

  def formtastic_tag_submit
    @user = User.new(params[:user])
    if @user.valid_with_captcha?
      render text: 'captcha valid!'
    else
      render :formtastic_tag
    end
  end
end
