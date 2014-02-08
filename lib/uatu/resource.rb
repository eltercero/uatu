module Uatu
  class Resource < Hashie::Mash

    def initialize(resource_hash, default=nil, &blk)
      super(improve_hash(resource_hash), default, &blk)
    end

    def improve_hash(original_hash)
      resource_hash_w_underscore = underscore_keys(original_hash)
      add_shortcuts(resource_hash_w_underscore)
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

    # That "thumbnail" hash in the original response drives me crazy
    def add_shortcuts(args)
      _args = {}
      args.each do |k, v|
        _args[k] = case k.to_s
          when 'thumbnail' then [v['path'],v['extension']].join('.')
          else v
        end
      end
      _args
    end

  end

  class Character < Resource ; end  
  class Event < Resource ; end  
  class Comic < Resource ; end  
  class Story < Resource ; end  
  class Serie < Resource ; end  
  class Creator < Resource ; end  
end