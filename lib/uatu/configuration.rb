module Uatu
  module Configuration

    CREDENTIALS = [:public_key, :private_key]

    PUBLIC_KEY  = ENV["MARVEL_PUBLIC_KEY"]
    PRIVATE_KEY = ENV["MARVEL_PRIVATE_KEY"]

    attr_accessor *CREDENTIALS

    def self.extended(base)
      base.reset
    end

    def reset
      self.public_key  = PUBLIC_KEY
      self.private_key = PRIVATE_KEY
    end

    def configure
      yield self
    end

  end
end