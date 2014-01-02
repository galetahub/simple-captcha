require 'test_helper'
require 'simple_captcha/controller'

class FormHelperTest  < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    SimpleCaptcha.always_pass = false
  end

  test 'displays captcha and passes' do
    visit '/pages/form_tag'
    assert_equal 1, SimpleCaptcha::SimpleCaptchaData.count
    fill_in 'captcha', with: SimpleCaptcha::SimpleCaptchaData.first.value
    click_on 'Save changes'
    assert page.has_content? 'captcha valid'
  end

  test 'captcha fails' do
    visit '/pages/form_tag'
    assert_equal 1, SimpleCaptcha::SimpleCaptchaData.count
    fill_in 'captcha', with: 'something else'
    click_on 'Save changes'
    assert page.has_content? 'captcha not valid'
  end

  test 'also works with model based' do
    visit '/pages/model_tag'
    assert_equal 1, SimpleCaptcha::SimpleCaptchaData.count
    fill_in 'user[captcha]', with: SimpleCaptcha::SimpleCaptchaData.first.value
    click_on 'Save changes'
    assert page.has_content? 'captcha valid'
  end
  test 'model based failure' do
    visit '/pages/model_tag'
    assert_equal 1, SimpleCaptcha::SimpleCaptchaData.count
    fill_in 'user[captcha]', with: 'wrong captcha'
    click_on 'Save changes'
    assert page.has_content? 'captcha not valid'
  end
end
