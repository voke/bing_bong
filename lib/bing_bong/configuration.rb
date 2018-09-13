module BingBong
  class Configuration

    DEFAULT_VERSION = :v12

    attr_accessor :account_id, :customer_id, :environment,
      :developer_token, :username, :password, :access_token, :debug, :version

    def initialize
      self.access_token = ENV['BING_ACCESS_TOKEN']
      self.account_id = ENV['BING_ACCOUNT_ID']
      self.customer_id = ENV['BING_CUSTOMER_ID']
      self.developer_token = ENV['BING_DEVELOPER_TOKEN']
      self.username = ENV['BING_USERNAME']
      self.password = ENV['BING_PASSWORD']
      self.environment = :sandbox
      self.version = DEFAULT_VERSION
    end

    def merge(options = {})
      clone.tap do |copy|
        options.each do |key, value|
          copy.public_send("#{key}=", value)
        end
      end
    end

  end
end
