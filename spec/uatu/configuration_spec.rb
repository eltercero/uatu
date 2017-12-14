require 'spec_helper'

RSpec.describe Uatu::Configuration do

  class Klass
    extend Uatu::Configuration
  end

  let(:klass) { Klass }

  describe '.configure' do
    let(:public_key) { 'PUBLIC_KEY' }
    let(:private_key) { 'private_key' }

    it "should set the public and private key" do
      klass.configure do |config|
        config.public_key = public_key
        config.private_key = private_key
      end

      expect(klass.public_key).to eq public_key
      expect(klass.private_key).to eq private_key
    end
  end

end