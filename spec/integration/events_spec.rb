require 'spec_helper'

RSpec.describe "Events" do

  let(:uatu) { Uatu::Base.new }

  it 'retrieves events' do
    events = uatu.events

    expect(events.size).to eq 5
    expect(events.first.title).to eq "Annihilation"
  end

  it 'retrieves a single event' do
    event = uatu.event(233)
    expect(event.title).to eq "Atlantis Attacks"
  end

end
