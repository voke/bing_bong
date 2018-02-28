require 'savon'

module BingBong
  class Service < SimpleDelegator

    DEFAULT_VERSION = :v11
    DEFAULT_ENVIRONMENT = :development

    attr_accessor :name, :version, :config

    def initialize(name, config, version = DEFAULT_VERSION)
      self.name = name
      self.version = version
      self.config = config
      __setobj__(instantiate_client)
    end

    # http://msdn.microsoft.com/en-US/library/bing-ads-overview-account-customer-identifiers.aspx
    def default_headers
      {
        'tns:AuthenticationToken' => config.auth_token,
        'tns:CustomerAccountId' => config.account_id,
        'tns:CustomerId' => config.customer_id,
        'tns:DeveloperToken' => config.developer_token,
        'tns:UserName' => config.username,
        'tns:Password' => config.password
      }.reject { |_,value| value.nil? }
    end

    def wsdl_url
      Endpoint.get(name, config.environment)
    end

    def instantiate_client
      Savon.client(
        soap_header: default_headers,
        wsdl: wsdl_url,
        log_level: :debug,
        log: true,
        pretty_print_xml: true
      )
    end

  end
end
