module Uatu
  module Configuration

    VALID_CONFIG_KEYS = [:public_key, :private_key]

    PUBLIC_KEY      = ENV["MARVEL_PUBLIC_KEY"]
    PRIVATE_KEY     = ENV["MARVEL_PRIVATE_KEY"]

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def credentials
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    def reset
      self.public_key   = PUBLIC_KEY
      self.private_key  = PRIVATE_KEY
    end

  end
end