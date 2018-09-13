module BingBong
  class Configuration

    attr_accessor :account_id, :customer_id, :environment,
      :developer_token, :username, :password, :access_token, :debug, :version

    def initialize
      self.access_token = nil
      self.account_id = nil
      self.customer_id = nil
      self.developer_token = nil
      self.username = nil
      self.password = nil
      self.environment = :sandbox
      self.version = :v12
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
