# Omniauth::NexaasID

Nexaas ID OAuth2 Strategy for OmniAuth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-nexaas-id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-nexaas-id

## Usage

`OmniAuth::Strategies::NexaasID` is simply a Rack middleware. Read the OmniAuth docs for detailed information: https://github.com/omniauth/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :nexaas_id, ENV['NEXAAS_ID_TOKEN'], ENV['NEXAAS_ID_SECRET']
end
```

You can optionally specify the URL as an option (useful in case you want to point to Nexaas ID's staging environment):

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :nexaas_id, ENV['NEXAAS_ID_TOKEN'], ENV['NEXAAS_ID_SECRET'], client_options: { site: ENV['NEXAAS_ID_URL'] }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/myfreecomm/omniauth-nexaas-id.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

