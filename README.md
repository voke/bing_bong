
![BingBong](https://raw.githubusercontent.com/voke/bing_bong/master/bingbong.png)

# BingBong

Small wrapper for the Bing Ads API. __This is work in progress!__

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
  config.access_token = nil # Not supported in sandbox
  config.account_id = 12345
  config.customer_id = 1337
  config.developer_token = 'BBD37VB98'
  config.username = 'johndoe_sbx'
  config.password = 'secret'
  config.environment = :sandbox
end

campaign_srv = bing.service(:campaign_management_service)
message = { 'AccountId' => 12345 }
response = campaign_srv.call(:get_campaigns_by_account_id, message: message)

p response.body

```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
