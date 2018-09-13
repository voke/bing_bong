require 'savon'

module BingBong
  class Service < SimpleDelegator

    DEFAULT_ENVIRONMENT = :development

    attr_accessor :name, :version, :config

    def initialize(name, config)
      self.name = name
      self.version = version
      self.config = config
      __setobj__(instantiate_client)
    end

    # http://msdn.microsoft.com/en-US/library/bing-ads-overview-account-customer-identifiers.aspx
    def default_headers
      {
        'tns:AuthenticationToken' => config.access_token,
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

    # Detect the AuthenticationTokenExpired (109) error code.
    # This will allow user to refresh the access token automatically.
    def call(*args)
      super
    rescue Savon::SOAPFault => e
      payload = e.to_hash[:fault]
      errors = [payload[:detail][:ad_api_fault_detail][:errors][:ad_api_error]]
      if errors.any? { |err| err[:code].to_i == 109 }
        raise BingBong::TokenExpiredError
      else
        raise e
      end
    end

    def instantiate_client
      Savon.client(
        soap_header: default_headers,
        wsdl: wsdl_url,
        log_level: config.debug ? :debug : :info,
        log: !!config.debug,
        pretty_print_xml: true
      )
    end

  end
end
