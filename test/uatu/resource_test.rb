require 'helper'


describe '.initialize' do
  

  it "should underscore the response keys and add the shortcuts" do
    original = {"id"=>1009521,
                "name"=>" Hank Pym",
                "resourceURI" => "http://gateway.marvel.com/v1/public/characters/1009521",
                "thumbnail" => 
                  { "path" => "http://i.annihil.us/u/prod/marvel/i/mg/8/c0/4ce5a0e31f109",
                    "extension" => "jpg" 
                  },
                "comics"=>
                  { "available"=>44,
                    "items"=>
                    [{"resourceURI"=>"http://gateway.marvel.com/v1/public/comics/35533",
                      "name"=>"Amazing Spider-Man (1999) #661"}]
                  }
                }

    resource = Uatu::Resource.new(original)
    resource.thumbnail.must_equal "http://i.annihil.us/u/prod/marvel/i/mg/8/c0/4ce5a0e31f109.jpg"
    resource.resource_uri.must_equal "http://gateway.marvel.com/v1/public/characters/1009521"
    resource.resourceURI.must_equal nil 
    resource.comics.items.first.resource_uri.must_equal "http://gateway.marvel.com/v1/public/comics/35533"
    resource.comics.items.first.resourceURI.must_equal nil
  end



end