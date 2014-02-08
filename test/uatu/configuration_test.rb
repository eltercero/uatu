require 'helper'


describe '.configure' do
  after do
    Uatu.reset
  end
  
  it "should set the public and private key" do
    Uatu.configure do |config|
      config.public_key = 'PUBLIC_KEY'
      config.private_key = 'PRIVATE_KEY'
    end

    Uatu.public_key.must_equal 'PUBLIC_KEY'
    Uatu.private_key.must_equal 'PRIVATE_KEY'
  end

end