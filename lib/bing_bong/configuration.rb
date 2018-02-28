module BingBong
  class Configuration

    attr_accessor :account_id, :customer_id, :environment,
      :developer_token, :username, :password, :auth_token

    def initialize
      self.auth_token = ENV['BING_AUTH_TOKEN']
      self.account_id = ENV['BING_ACCOUNT_ID']
      self.customer_id = ENV['BING_CUSTOMER_ID']
      self.developer_token = ENV['BING_DEVELOPER_TOKEN']
      self.username = ENV['BING_USERNAME']
      self.password = ENV['BING_PASSWORD']
      self.environment = :sandbox
    end

  end
end
