# Omniauth::Untappd

Untappd OAuth2 Strategy for OmniAuth.

[![Gem Version](https://badge.fury.io/rb/omniauth-untappd.png)](http://badge.fury.io/rb/omniauth-untappd)

## Installation

Add to your `Gemfile`:

    gem 'omniauth-untappd'

And then execute:

    $ bundle install

## Usage

### Rails

Add this to or create `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :untappd, ENV['UNTAPPD_KEY'], ENV['UNTAPPD_SECRET']
end
```

See more details on the omniauth module: https://github.com/intridea/omniauth#readme

## Supported Rubies

OmniAuth Untappd is tested under 1.9.2, 1.9.3 and 2.0.0

[![Build Status](https://travis-ci.org/sabotatore/omniauth-untappd.png)](https://travis-ci.org/sabotatore/omniauth-untappd) [![Code Climate](https://codeclimate.com/github/sabotatore/omniauth-untappd.png)](https://codeclimate.com/github/sabotatore/omniauth-untappd)

## License

Copyright (c) 2013 Vitali Kulikou

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
