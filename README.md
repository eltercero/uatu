# Uatu

Uatu is a Wrapper for the Marvel API. See [the API](http://developer.marvel.com) for more details. This a work in progress.

Uatu relies on OpenStruct to build ruby objects with the API response. 

Uatu is [also](http://en.wikipedia.org/wiki/Uatu) a member of The Watchers, that nice extraterrestrial race who monitor life of other species.

## Installation

Add this line to your application's Gemfile:

    gem 'uatu', git: https://github.com/eltercero/uatu

And then execute:

    $ bundle

## Usage

```ruby
require 'uatu'

# You can also have them in your env.
Uatu.configure do |config|
  config.public_key = 'your_api_key'
  config.private_key = 'your_private_api_key'
end

watcher = Uatu::Base.new

# Examples
#####################################################
# Searching by characters return an Array of results
character = watcher.characters(name: 'Daredevil').first
character.name
=> 'Daredevil'
character.description
=> "Abandoned by his mother, Matt Murdock was raised by his father, boxer \"Battling Jack\" Murdock, in Hell's Kitchen. Realizing that rules were needed to prevent people from behaving badly, young Matt decided to study law; however, when he saved a man from an oncoming truck, it spilled a radioactive cargo that rendered Matt blind while enhancing his remaining senses. Under the harsh tutelage of blind martial arts master Stick, Matt mastered his heightened senses and became a formidable fighter."

random_hero = watcher.characters(limit: 1, offset: rand(1000)).first.name
=> "Dreaming Celestial"
random_heroes_team = watcher.characters(limit: 20, offset: rand(1000)).map(&:name)
=> ["Rumiko Fujikawa", "Runaways", "Russian", "S.H.I.E.L.D.", "Sabra", "Sabretooth", "Sabretooth (Age of Apocalypse)", "Sabretooth (House of M)", "Sabretooth (Ultimate)", "Sage", "Salem's Seven (Ultimate)", "Sally Floyd", "Salo", "Sandman", "Santa Claus", "Saracen (Muzzafar Lambert)", "Sasquatch (Walter Langkowski)", "Satana", "Sauron", "Scalphunter"]

# Parameters are in ruby style. This means no camel case like firstName 
irish_fella = watcher.creators(first_name: 'Garth', last_name: 'Ennis').first
irish_fella.comics.available
=> 103

#You can also search by id
character = watcher.character(1009262)
character.thumbnail 
=> "http://i.annihil.us/u/prod/marvel/i/mg/d/50/50febb79985ee.jpg"

#There is also a handy method for checking out the last url you requested
watcher.last_request_url
=> "http://gateway.marvel.com/v1/public/characters/1009262?apikey=xxx&hash=xxx&ts=2014-02-08T18%3A52%3A25%2B01%3A00"

#For combined calls (like, comics in a character => GET /v1/public/characters/{characterId}/comics), you make them like this
asgardian_god_comics = watcher.character_comics(1009664)
asgardian_god_comics.first.title
"Thor: God of Thunder (2012) #2" # Which is, by the way, an amazing comic.
asgardian_god_comics.
```

## Contributing

Please, be my guest!

1. Fork it ( http://github.com/eltercero/uatu/fork )
2. Create your feature branch (`git checkout -b nuff-said`)
3. Commit your changes (`git commit -am 'Excelsior!'`)
4. Push to the branch (`git push origin nuff-said`)
5. Create new Pull Request

## License

Released under the [MIT License](http://opensource.org/licenses/MIT).