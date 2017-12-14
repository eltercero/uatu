module Uatu
  class Resource < OpenStruct

    def initialize(original_hash)
      super(improve_values(underscore_keys(original_hash)))
    end

  private

    # Underscore names of the Hash. I mean... this is Ruby, right?.
    def underscore_keys(hash)
      _hash = {}
      hash.each do |key, value|
        _hash[key.to_s.underscore] = if value.is_a?(Hash)
          underscore_keys(value)
        elsif value.is_a?(Array) and value.first.is_a?(Hash)
          value.map{|h| underscore_keys(h)}
        else
          value
        end
      end
      _hash
    end

    # We change the hashes to mashes (Hashie::Mash) so it's easier to manipulate
    # The 'thumbnail' hash drives me crazy, we convert it to a single value.
    def improve_values(hash)
      _hash = {}
      hash.each do |key, value|
        _hash[key] = if key.to_s=='thumbnail' && !value.nil?
          [value['path'],value['extension']].join('.')
        elsif value.is_a?(Hash)
          Hashie::Mash.new(value)
        else
          value
        end
      end
      _hash
    end

  end
end

class Uatu::Character < Uatu::Resource ; end
class Uatu::Event < Uatu::Resource     ; end
class Uatu::Comic < Uatu::Resource     ; end
class Uatu::Story < Uatu::Resource     ; end
class Uatu::Serie < Uatu::Resource     ; end
class Uatu::Creator < Uatu::Resource   ; end
