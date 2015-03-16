# minitest-flog

Beat your code, see where it bleeds.

Flog analyzes Ruby code for signs of complexity and produces a numeric score
for each method and class in every file it scans.  A higher score is indicative
of more complex constructs and therefore refactoring opportunities.

This gem integrates Flog directly into your project's test suite so that you're
automatically alerted to any additions or updates that will lead to pain down
the line.

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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/minitest-flog/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The MIT License (MIT)

Copyright (c) 2015 Chris Kottom

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
