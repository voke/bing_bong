module BingBong
  class Client

    def initialize
      yield config
    end

    def config
      @configuration ||= BingBong::Configuration.new
    end

    def service(name, version = :v11)
      BingBong::Service.new(name, config, version)
    end

  end
end
