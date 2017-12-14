require 'spec_helper'

describe Uatu::Connection do

  subject { described_class.new }

  describe '#params_by' do
    let(:options) do
      {
        :format_type     => 'comic',
        :date_descriptor => 'lastWeek',
        :limit           => 20,
        :character_id    => '1009262'
      }
    end

    it 'prepares the options' do
      unrubified = subject.send(:params_by, options)

      expect(unrubified[:formatType]).to eq 'comic'
      expect(unrubified[:dateDescriptor]).to eq 'lastWeek'
      expect(unrubified[:limit]).to eq 20
      expect(unrubified[:characterId]).to eq nil
    end
  end

  describe '#path_by' do
    it "should build normal routes just fine" do
      route = subject.send(:path_by, 'character')
      expect(route).to eq "/v1/public/characters"

      route = subject.send(:path_by, 'characters')
      expect(route).to eq "/v1/public/characters"

      route = subject.send(:path_by, 'character', {character_id: '1009262'})
      expect(route).to eq "/v1/public/characters/1009262"
    end
  end

end