class Endpoint

  ENDPOINTS = {
    production: {
      customer_management_service: 'https://clientcenter.api.bingads.microsoft.com/Api/CustomerManagement/v11/CustomerManagementService.svc?singleWsdl',
      campaign_management_service: 'https://campaign.api.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v11/CampaignManagementService.svc?singleWsdl'
    },
    sandbox: {
      customer_management_service: 'https://clientcenter.api.sandbox.bingads.microsoft.com/Api/CustomerManagement/v11/CustomerManagementService.svc?singleWsdl',
      campaign_management_service: 'https://campaign.api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v11/CampaignManagementService.svc?singleWsdl'
    }
  }

  def self.get(service_name, env)
    env = ENDPOINTS[env.to_sym] || raise(ArgumentError, "Invalid environment: #{env.inspect}. Supported: #{ENDPOINTS.keys.join(',')}")
    env[service_name.to_sym] || raise(ArgumentError, "Invalid service: #{service_name}.")
  end

end
