require 'delegate'

module BingBong
  class Token < DelegateClass(Hash)

    def initialize(attributes = {})
      attributes['expires_at'] ||= Time.now.to_i + attributes['expires_in']
      super(attributes)
    end

    def expired?
      Time.now.to_i > self['expires_at'].to_i
    end

  end
end
