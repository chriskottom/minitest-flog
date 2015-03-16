# minitest-flog

Beat your code, see where it bleeds.

Flog analyzes Ruby code for signs of complexity and produces a numeric score
for each method and class in every file it scans.  A higher score is indicative
of more complex constructs and therefore refactoring opportunities.

This gem integrates Flog directly into your project's test suite so that you're
automatically alerted to any changes that 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-flog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-flog

You'll need to require the library in your test helper:

```ruby
require "minitest/flog"
```

## Usage

minitest-flog introduces a new Minitest::Flog::Test class that you'll
use to make any assertions about complexity in your project.

Create a new test by subclassing Minitest::Flog::Test.  You can then make
assertions about the Flog scoring you expect to calculate for code in selected
directories in your project.  The example below has two assertions:

* No method should have a score over 100.0.
* 95% of all methods should have scores less than or equal to 40.0.

```ruby
class MyProjectFlogger < Minitest::Test
  def flog_lib
    assert_method_score("lib", score: 100.0)
	assert_method_score("lib", score: 40.0, ratio: 0.95)
  end
end
```

## To-Dos

TO-DO: list these TO-DOs

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/minitest-flog/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
