module BingBong
  class Client

    def initialize
      yield config
    end

    def config
      @config ||= BingBong::Configuration.new
    end

    def service(name, overrides = {})
      BingBong::Service.new(name, config.merge(overrides))
    end

  end
end
