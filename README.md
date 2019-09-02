# Metrc

Metrc Ruby API Wrapper - ALPHA!!! DO NOT USE IN PRODUCTION ENVIRONMENT YET

Metrc API Docs: https://api-co.metrc.com/Documentation/ (replace 'co' with whatever state metrc operates in)

Note: Most, if not all, endpoints now work for both get and post. I still do not recommend using in a production environment yet as no formal tests have been written. 

Special Thanks: buttercloud for his tookan api gem. This gem is forked from that and modified for metrc. https://github.com/buttercloud/tookan_ruby_api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metrc_api_gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metrc_api_gem

## Usage

Initialize the class

```ruby
m = Metrc::Client.new
```

Set your endpoint and vendor api key

```ruby
m.default_body[:vendor_api_key] = 'XXXXXXXXXXXXXXXXXXXXXXXXX'
m.endpoint = 'https://sandbox-api-ca.metrc.com'
```

Use any of the endpoints in the API as Ruby methods. Metrc requires 2 api keys, the vendor and the user. Pass the User api key in as an argument. Your vendor key should be located in credentials namespaced by rails environment, state(like :metrc_california) and finally named :vendor_api_key
  
```ruby  
m.get_facilities_v1(user_api_key)
# OR
m.get_packages_v1_active(user_api_key, {license_number: 'XXXXXXXXX-LIC'})
```

There is another couple useful methods.
	
```ruby
f = m.get_facilities_v1(user_api_key)
f = m.symbolize_response(f)
m.save_response_to_object!(f, my_obj)
```

```symbolize_response``` will take any metrc response and turn their camel case string keys into snake case symbols. **HOWEVER** this does not working with responses that the value is an array like get_sales_receipts. I will get around too this sometime. I don't need any endpoints that have this so it isn't a priority right now.

```save_response_to_object!``` is a mutating method that will iterate through the response and save the data to whatever object you pass in at ```my_obj```. Please note, the saving looks something like this 

```ruby
def save_response_to_object!(response, user_object)
  response.each do |key, value|
    user_object[key] = value if user_object.respond_to?(key)
  end
end
```

The method is fairly simple but idea here is to save what we want to save and leave the rest. The limitation is you must name your columns in your database identical to my snake case version. 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
