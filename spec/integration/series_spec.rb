require 'spec_helper'

RSpec.describe "Series" do

  let(:uatu) { Uatu::Base.new }

  it 'retrieves series' do
    series = uatu.series

    expect(series.size).to eq 6
    expect(series.first.title).to eq "Alias Vol. 2: Come Home (2003)"
  end

  it 'retrieves a single serie' do
    serie = uatu.serie(155)
    expect(serie.title).to eq "Alias Vol. 2: Come Home (2003)"
  end

end
