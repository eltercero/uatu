require 'spec_helper'

describe Uatu::Connection do

  let(:resource) { 'characters' }
  let(:options) do
    {
      :format_type     => 'comic',
      :date_descriptor => 'lastWeek',
      :limit           => 20,
      :character_id    => '1009262'
    }
  end

  subject { described_class.new resource, options}

  describe '#params' do
    it 'prepares the options' do
      unrubified = subject.send(:params)

      expect(unrubified[:formatType]).to eq 'comic'
      expect(unrubified[:dateDescriptor]).to eq 'lastWeek'
      expect(unrubified[:limit]).to eq 20
      expect(unrubified[:characterId]).to eq nil
    end
  end

  describe '#path' do
    context 'single resource' do
      let(:options) { {} }
      let(:resource) { 'character' }
      it "should build normal routes just fine" do
        expect(subject.send(:path)).to eq "/v1/public/characters"
      end
    end

    context 'collection' do
      let(:options) { {} }
      let(:resource) { 'characters' }
      it "should build normal routes just fine" do
        expect(subject.send(:path)).to eq "/v1/public/characters"
      end
    end

    context 'with id' do
      let(:resource) { 'characters' }
      let(:options) { {character_id: '1009262'} }
      it "should build normal routes just fine" do
        expect(subject.send(:path)).to eq "/v1/public/characters/1009262"
      end
    end
  end

end