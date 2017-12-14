require "bundler/setup"
require "uatu"
require 'webmock/rspec'
require 'support/fake_marvel_api'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    stub_request(:any, /gateway.marvel.com/).to_rack(FakeMarvelApi)
  end
end
