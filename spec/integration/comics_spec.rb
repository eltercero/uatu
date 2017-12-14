require 'spec_helper'

RSpec.describe "Comics" do

  let(:uatu) { Uatu::Base.new }

  it 'retrieves comics' do
    comic = uatu.comics.first
    expect(comic.title).to eq "Black Panther: The Man Without Fear - The Complete Collection (Trade Paperback)"
  end

  it 'retrieves a single comic' do
    comic = uatu.comic(65443)
    expect(comic.title).to eq "Black Panther: The Man Without Fear - The Complete Collection (Trade Paperback)"
  end

end
