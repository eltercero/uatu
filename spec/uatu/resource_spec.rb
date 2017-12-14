require 'spec_helper'

describe Uatu::Resource do
  let(:id) { 1009521 }
  let(:name) { "Hank Pym" }
  let(:resourceURI) { "http://gateway.marvel.com/v1/public/characters/1009521" }
  let(:thumbnail_path) { "http://i.annihil.us/u/prod/marvel/i/mg/8/c0/4ce5a0e31f109" }
  let(:thumbnail_extension) { "jpg" }

  let(:params) do
    {
      "id" => id,
      "name" => name,
      "resourceURI" => resourceURI,
      "thumbnail" => {
        "path" => thumbnail_path,
        "extension" => thumbnail_extension
      },
      "comics"=> {
        "available"=>44,
        "items"=> [
          {"resourceURI"=>"http://gateway.marvel.com/v1/public/comics/35533",
            "name"=>"Amazing Spider-Man (1999) #661"}
        ]
      }
    }
  end

  subject { described_class.new params }

  describe '.initialize' do
    it 'initializes the right values' do
      expect(subject.thumbnail).to eq "#{thumbnail_path}.#{thumbnail_extension}"
      expect(subject.resource_uri).to eq resourceURI
      expect(subject.resourceURI).to eq nil
      expect(subject.comics.items.first.resource_uri).to eq "http://gateway.marvel.com/v1/public/comics/35533"
      expect(subject.comics.items.first.resourceURI).to eq nil
    end
  end
end
