class Endpoint

  ENDPOINTS = {
    customer_management_service: {
      production: "https://clientcenter.api.bingads.microsoft.com/Api/CustomerManagement/v12/CustomerManagementService.svc?wsdl",
      sandbox: "https://clientcenter.api.sandbox.bingads.microsoft.com/Api/CustomerManagement/v12/CustomerManagementService.svc?wsdl"
    },
    campaign_management_service: {
      production: 'https://campaign.api.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v12/CampaignManagementService.svc?wsdl',
      sandbox: 'https://campaign.api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v12/CampaignManagementService.svc?wsdl'
    }
  }

  def self.get(service_name, environment)
    ENDPOINTS.fetch(service_name.to_sym) do
      raise(ArgumentError, "Invalid service: #{service_name}.")
    end.fetch(environment.to_sym) do
      raise(ArgumentError, "Invalid environment: #{environment.inspect}.")
    end
  end

end
