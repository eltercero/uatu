require 'spec_helper'

RSpec.describe "Creators" do

  let(:uatu) { Uatu::Base.new }

  it 'retrieves creators' do
    creators = uatu.creators

    expect(creators.size).to eq 3
    expect(creators.last.full_name).to eq "Abel"
  end

  it 'retrieves a single creator' do
    creator = uatu.creator(2)
    expect(creator.full_name).to eq "Garth Ennis"
  end

end
