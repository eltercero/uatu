require 'spec_helper'

RSpec.describe "Characters" do

  let(:uatu) { Uatu::Base.new }

  it 'retrieves characters' do
    hero = uatu.characters(name: 'Daredevil').first
    expect(hero.name).to eq 'Daredevil'
  end

  it 'retrieves a single character' do
    hero = uatu.character(1009262)
    expect(hero.name).to eq 'Daredevil'
  end

  it 'retrieves a resource from the character' do
    hero_comics = uatu.character_comics(1009262)
    expect(hero_comics.first.class).to eq Uatu::Comic

    characters = hero_comics.first.characters.items
    expect(characters.any?{|item| item['name'] == 'Daredevil' }).to be true
  end

end
