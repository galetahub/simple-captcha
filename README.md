#SimpleCaptcha2

[![Build Status](https://travis-ci.org/pludoni/simple-captcha.png?branch=master)](https://travis-ci.org/pludoni/simple-captcha)

SimpleCaptcha(2) is the simplest and a robust captcha plugin. Its implementation requires adding up a single line in views and in controllers/models.
SimpleCaptcha2 is available to be used with Rails 3 + 4.
This is a fork of the popular Rubygem ``simple_captcha`` which got abandoned.

##Features

* Zero FileSystem usage (secret code moved to db-store and image storage removed).
* Provides various image styles.
* Provides three level of complexity of images.
* Works absolutely fine in distributed environment(session and db based implementation works fine in distributed environment).
* Implementation is as easy as just writing a single line in your view. ```<%= show_simple_captcha %>``` within the 'form' tags.
* Flexible DOM and CSS handling(There is a separate view partial for rendering SimpleCaptcha DOM elements).
* Automated removal of 1 hour old unmatched simple_captcha data.

##Requirements

* Ruby >= 1.9.3
* Rails >= 3.2
* ImageMagick should be installed on your machine to use this plugin.
  visit http://www.imagemagick.org/script/index.php for more details.

You might need to install Ghostscript on a Mac-System:

```
brew install ghostscript
```

##Installation

Put this into your Gemfile

```ruby
gem 'simple_captcha2', require: 'simple_captcha'
```

and run ``bundle install``.

## Setup

After installation, follow these simple steps to setup the plugin. The setup will depend on the version of rails your application is using.

```bash
rails generate simple_captcha
rake db:migrate
```

## Usage

There are two usage scenarios:

### Controller Based

Add the following line in the file "app/controllers/application.rb"

```ruby
ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
end
```

In the view file within the form tags add this code

```erb
<%= show_simple_captcha %>
```

and in the controller's action authenticate it as

```ruby
if simple_captcha_valid?
  do this
else
  do that
end
```

### Model Based

This is suggested, if you want to integrate the error message into the normal form validation flow.

In the view file within the form tags write this code

```erb
<%= show_simple_captcha(:object=>"user") %>
```

and in the model class add this code

```ruby
class User < ActiveRecord::Base
  apply_simple_captcha
end
```

####Form-Builder helper

```erb
<%= form_for @user do |form| -%>
  ...
  <%= form.simple_captcha :label => "Enter numbers.." %>
  ...
<% end -%>
```

####Validating with captcha

NOTE: @user.valid? will still work as it should, it will not validate the captcha code.

```ruby
@user.valid_with_captcha?
```

####Saving with captcha

NOTE: @user.save will still work as it should, it will not validate the captcha code.

```ruby
@user.save_with_captcha
```

###Formtastic integration

SimpleCaptcha detects if you are using Formtastic:

```erb
<%= form.input :captcha, :as => :simple_captcha %>
```

### Tests

You can make the Captcha always pass with a initializer file: config/initializers/simple_captcha.rb

```ruby
SimpleCaptcha.always_pass = Rails.env.test?
```

You can also ask for the value, e.g. Acceptance Tests/Features:

```ruby
visit '/pages/form_tag'
assert_equal 1, SimpleCaptcha::SimpleCaptchaData.count
fill_in 'captcha', with: SimpleCaptcha::SimpleCaptchaData.first.value
```

##Options & Examples

###View Options

* ``:label`` - provides the custom text b/w the image and the text field, the default is "type the code from the image"
* ``:object`` - the name of the object of the model class, to implement the model based captcha.
* ``:code_type`` - return numeric only if set to 'numeric'

###Global options

* ``:image_style`` - provides the specific image style for the captcha image.
There are eight different styles available with the plugin as...

1. simply_blue
2. simply_red
3. simply_green
4. charcoal_grey
5. embosed_silver
6. all_black
7. distorted_black
8. almost_invisible

Default style is 'simply_blue'.
You can also specify 'random' to select the random image style.

* ``:distortion`` - handles the complexity of the image. The :distortion can be set to 'low', 'medium' or 'high'. Default is 'low'.

Create "./config/initializers/simple_captcha.rb"

```ruby
SimpleCaptcha.setup do |sc|
  # default: 100x28
  sc.image_size = '120x40'

  # default: 5
  sc.length = 6

  # default: simply_blue
  # possible values:
  # 'embosed_silver',
  # 'simply_red',
  # 'simply_green',
  # 'simply_blue',
  # 'distorted_black',
  # 'all_black',
  # 'charcoal_grey',
  # 'almost_invisible'
  # 'random'
  sc.image_style = 'simply_green'

  # default: low
  # possible values: 'low', 'medium', 'high', 'random'
  sc.distortion = 'medium'
end
```

You can add your own style:

```ruby
SimpleCaptcha.setup do |sc|
  sc.image_style = 'mycaptha'
  sc.add_image_style('mycaptha', [
      "-background '#F4F7F8'",
      "-fill '#86818B'",
      "-border 1",
      "-bordercolor '#E0E2E3'"])
end
```

You can provide the path where image_magick is installed as well:

```ruby
SimpleCaptcha.setup do |sc|
  sc.image_magick_path = '/usr/bin' # you can check this from console by running: which convert
end
```

You can provide the path where should be stored tmp files.
It's usefull when you dont have acces to /tmp (default directory)

```ruby
SimpleCaptcha.setup do |sc|
  sc.tmp_path = '/tmp' # or somewhere in project eg. Rails.root.join('tmp/simple_captcha').to_s, make shure directory exists
end
```


### How to change the CSS for SimpleCaptcha DOM elements?

You can change the CSS of the SimpleCaptcha DOM elements as per your need in this file.

``app/views/simple_captcha/_simple_captcha.erb``

###View's Examples
####Controller Based Example

```erb
<%= show_simple_captcha %>

<%= show_simple_captcha(:label => "human authentication") %>
```

####Model Based Example

```erb
<%= show_simple_captcha(:object => 'user', :label => "human authentication") %>
```

####Model Options

* ``:message`` - provides the custom message on failure of captcha authentication the default is "Secret Code did not match with the Image"

* ``:add_to_base`` - if set to true, appends the error message to the base.

#####Model's Example

```ruby
class User < ActiveRecord::Base
  apply_simple_captcha
end

class User < ActiveRecord::Base
  apply_simple_captcha :message => "The secret Image and code were different", :add_to_base => true
end
```


##I18n

```yaml
en:
  simple_captcha:
    placeholder: "Enter the image value"
    label: "Enter the code in the box:"
    message:
      default: "Secret Code did not match with the Image"
      user: "The secret Image and code were different"
```

##Contributing

For testing, generate a temporary Rails dummy app inside test:

```bash
rake dummy:setup
rake app:db:migrate
rake app:db:migrate RAILS_ENV=test
export BUNDLE_GEMFILE=$PWD/Gemfile
cd test/dummy && rake db:migrate db:test:prepare
rake test
```

Please add test cases when adding new functionality. I started with some basic example integration tests for a very basic coverage.

The tests will be run on [Travis-CI](https://travis-ci.org/pludoni/simple-captcha).

##Who's who?

Enjoy the simplest captcha implementation.

Original Author of the Version for Rails 2:
Author: Sur, Blog: http://expressica.com, Contact: sur.max@gmail.com
Plugin Homepage: http://expressica.com/simple_captcha

Plugin update for rails 3: http://github.com/galetahub

update for Rails 4, tests and forked by Stefan Wienert (pludoni GmbH)
