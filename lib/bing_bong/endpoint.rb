class Endpoint

  ENDPOINTS = {
    customer_management_service: {
      production: "https://clientcenter.api.bingads.microsoft.com/Api/CustomerManagement/v12/CustomerManagementService.svc?singleWsdl",
      sandbox: "https://clientcenter.api.sandbox.bingads.microsoft.com/Api/CustomerManagement/v12/CustomerManagementService.svc?singleWsdl"
    },
    campaign_management_service: {
      production: 'https://campaign.api.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v12/CampaignManagementService.svc?singleWsdl',
      sandbox: 'https://campaign.api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v12/CampaignManagementService.svc?singleWsdl'
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
