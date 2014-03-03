require 'time'
require 'helper'
require 'pry'
describe '.base' do
  
  before do 
    keys?
    @uatu = Uatu::Base.new
  end

  it "should be able to connect to Marvel API and bring a character" do
    hero = @uatu.character(1009262)
    hero.name.must_equal 'Daredevil'
  end

  it "should be able to connect to Marvel API and bring a character by name" do
    hero = @uatu.characters(name: 'Daredevil').first
    hero.name.must_equal 'Daredevil'
  end

  it "should be able to connect to Marvel API and bring comics from a character " do
    hero_comics = @uatu.character_comics(1009262)
    hero_comics.first.class.must_equal Uatu::Comic
    hero_comics.first.characters.items.any?{|item| item['name'].must_equal 'Daredevil' } 
  end

  it "should be able to connect to Marvel API and bring a creator" do
    creator = @uatu.creator(2)
    creator.first_name.must_equal 'Garth'
  end

  it "should be able to connect to Marvel API and bring a creator by name" do
    creator = @uatu.creators(first_name: 'Garth', last_name: 'Ennis').first
    creator.first_name.must_equal 'Garth'
  end

  it "should be able to connect to Marvel API and bring an event" do
    event = @uatu.event(238)
    event.title.must_equal 'Civil War'
  end

  it "should be able to connect to Marvel API and bring an event by nae" do
    event = @uatu.events(name: 'Civil War').first
    event.id.must_equal 238
  end

  it "should be able to connect to Marvel API and bring a comic" do
    comic = @uatu.comic(41530)
    comic.title.must_equal 'Ant-Man: So (Trade Paperback)'
  end

  describe '#comics_by_date' do
    describe 'with dates in correct order' do
      it "should be able to connect to Marvel API and bring comics released on a date" do
        comics_by_date = @uatu.comics_by_date('2014/01/01','2014/02/14')
        assert Time.parse(comics_by_date.first.dates.first['date']) >= Time.parse("2014/01/01")
        assert Time.parse(comics_by_date.first.dates.first['date']) <= Time.parse("2014/02/14")
      end
    end

    describe 'with dates switched' do
      it "should be able to connect to Marvel API and bring comics released on a date" do
        comics_by_date = @uatu.comics_by_date('2014/02/14','2014/01/01')
        assert Time.parse(comics_by_date.first.dates.first['date']) >= Time.parse("2014/01/01")
        assert Time.parse(comics_by_date.first.dates.first['date']) <= Time.parse("2014/02/14")
      end
    end
  end
end
