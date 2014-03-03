module Uatu
  class Resource < OpenStruct

    def initialize(original_hash)
      super(improve_values(underscore_keys(original_hash)))
    end

    # Underscore names of the Hash. I mean... this is Ruby, right?.
    def underscore_keys(hash)
      _hash = {}
      hash.each do |k, v|
        _hash[k.to_s.underscore] = if v.is_a?(Hash)
          underscore_keys(v)
        elsif v.is_a?(Array) and v.first.is_a?(Hash)
          v.map{|h| underscore_keys(h)}
        else
          v
        end
      end
      _hash
    end

    # We change the hashes to mashes (Hashie::Mash) so it's easier to manipulate
    # The 'thumbnail' hash drives me crazy, we convert it to a single value.
    def improve_values(hash)
      _hash = {}
      hash.each do |k,v|
        _hash[k] = if k.to_s=='thumbnail'
          [v['path'],v['extension']].join('.')
        elsif v.is_a?(Hash)
          Hashie::Mash.new(v)
        else
          v
        end
      end
      _hash
    end

  end

  class Character < Resource ; end  
  class Event < Resource ; end  
  class Comic < Resource ; end  
  class Story < Resource ; end  
  class Serie < Resource ; end  
  class Creator < Resource ; end  
end
