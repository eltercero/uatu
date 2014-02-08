require 'helper'


describe '.connect' do
  
  before do 
    @uatu = Uatu::Base.new
  end

  it "should prepare options just fine" do
    unrubified = @uatu.prepare_options(format_type: 'comic', date_descriptor: 'lastWeek', limit: 20, character_id: '1009262')

    unrubified[:formatType].must_equal 'comic'
    unrubified[:dateDescriptor].must_equal 'lastWeek'
    unrubified[:limit].must_equal 20
    unrubified[:characterId].must_equal nil
  end

  it "should build normal routes just fine" do
    route = @uatu.build_route('character', {})
    route.must_equal "/v1/public/characters"

    route = @uatu.build_route('characters', {})
    route.must_equal "/v1/public/characters"

    route = @uatu.build_route('character', {character_id: '1009262'})
    route.must_equal "/v1/public/characters/1009262"

  end

end