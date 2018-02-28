
![BingBong](https://raw.githubusercontent.com/voke/bing_bong/master/bingbong.png)

# BingBong

I guess they're right. Bing Ads, although slow and dangerous behind the wheel,
can still serve a purpose.

This gem is made purely out of frustration working with the Bing API.

**DISCLAIMER:** Do not try this at home.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bing_bong', github: 'voke/bing_bong'
```

## Usage

### Sandbox

Digging in the sandbox requires a [sandbox account](https://docs.microsoft.com/en-us/bingads/guides/sandbox).

Authentication with a OAuth is not supported in sandbox so we fallback to username/password.

```ruby
bing = BingBong::Client.new do |config|
  config.auth_token = nil # Not supported in sandbox
  config.account_id = 12345
  config.customer_id = 1337
  config.developer_token = 'BBD37VB98'
  config.username = 'johndoe_sbx'
  config.password = 'secret'
  config.environment = :sandbox
end

campaign_srv = bing.service(:campaign_management_service, :v11)
message = { 'AccountId' => 12345 }
response = campaign_srv.call(:get_campaigns_by_account_id, message: message)

p response.body

```

### Production

```ruby
require 'redis'
require 'json'

client_id = '000000001234A123'
auth = BingBong::Authorizer.new(client_id)

DB = Redis.new

auth.load_token = -> { JSON.parse(DB.get('bingtoken') || '{}') }
auth.save_token = -> token { DB.set('bingtoken', JSON.dump(token)) }

bing = BingBong::Client.new do |config|
  config.auth_token = auth.access_token
  config.account_id = 123
  config.customer_id = 456
  config.developer_token = '<DEVELOPER_TOKEN>'
  config.environment = :production
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
