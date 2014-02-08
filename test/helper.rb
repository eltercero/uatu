require 'uatu'
require 'minitest/autorun'
require 'minitest/spec'

def keys?
  if ENV['MARVEL_PUBLIC_KEY'].nil? or ENV['MARVEL_PRIVATE_KEY'].nil?
    raise "WARNING: You must set pubic and private keys in your environment to run the tests."
  end
end