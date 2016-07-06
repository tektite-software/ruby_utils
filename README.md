# Tektite's Ruby Utils

[![Gem Version](https://badge.fury.io/rb/tektite_ruby_utils.svg)](https://badge.fury.io/rb/tektite_ruby_utils) [![Build Status](https://travis-ci.org/tektite-software/ruby_utils.svg?branch=master)](https://travis-ci.org/tektite-software/ruby_utils) [![Code Climate](https://codeclimate.com/github/tektite-software/ruby_utils/badges/gpa.svg)](https://codeclimate.com/github/tektite-software/ruby_utils) [![Test Coverage](https://codeclimate.com/github/tektite-software/ruby_utils/badges/coverage.svg)](https://codeclimate.com/github/tektite-software/ruby_utils/coverage) [![Inline docs](http://inch-ci.org/github/tektite-software/ruby_utils.svg?branch=master)](http://inch-ci.org/github/tektite-software/ruby_utils)


This gem contains a number of utilities, extensions, and helpers for Ruby to make developing applications easier and to enable better security and integration with other services.  Enjoy!  Suggestions are most welcome.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tektite_ruby_utils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tektite_ruby_utils

## Usage

Below is a list of everything this gem includes.

### PresentClass and `present`

`PresentClass` adds a new class and related helpers designed to be the opposite of `NilClass`, and includes `present` in the global namespace as the opposite of `nil`.  It is used to represent that a value is __not nil__ without exposing the value itself.  Unlike simple using `!nil?`, PresentClass returns an object that can be configured to carry variable amounts of data about the value behind it, such as the object's type and class.  `PRESENT` is also included as a constant, which is a frozen instance of PresentClass that `present` returns.

Furthermore, the extensions includes several helpers for working with any object, Hashes, and Arrays.

This is extremely useful if for example you would like to pass information about whether certain data _exists_ to a method without telling the method what the actual values of that data are.

For any object, you can use the `present?` method:

    class MyObject
      attr_accessor :my_value
      ...
    end

    my_object = MyObject.new my_value: "test"

    my_object.my_value.present?
    # => true

    nil.present?
    # => false

    present.present?
    # => true

    present.nil?
    # => false

    nil
    # => nil

    present
    # => present

For Arrays and Hashes, the `all_present?`, `each_present?`, and `mask_present` helper methods are available:

    array = [1, 2, nil]
    array.all_present?
    # => false
    array.each_present?
    # => [true, true, false]
    array.mask_present
    # => [present, present, nil]

    hash = {one: 1, two: 2, three: 3}
    hash.all_present?
    # => true
    hash.each_present?
    # => {one: true, two: true, three: true}
    hash.mask_present
    # => {one: present, two: present, three: present}

If you would like to return an instance of PresentClass that includes the type of the original value, just create a new instance of PresentClass directly specifying the `:type` attribute as a Class.  For all other users, simply set a variable to `present` as if you were using `nil`.  As a helper for this, the `present_with_type` method is available:

    test_array = [1, 'two', :three]
    test_array.each do |e|
      puts e.present_with_type.type
      puts "\n"
    end

    # => Fixnum
    # => String
    # => Symbol

## Documentation

Documentation for this gem can be found here: http://www.rubydoc.info/github/tektite-software/ruby_utils/

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tektite-software/ruby_utils.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
