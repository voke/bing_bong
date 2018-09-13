module BingBong
  class Client

    DEFAULT_VERSION = :v12

    def initialize
      yield config
    end

    def config
      @config ||= BingBong::Configuration.new
    end

    def service(name, overrides = {})
      BingBong::Service.new(name, config.merge(overrides), config.version)
    end

  end
end
