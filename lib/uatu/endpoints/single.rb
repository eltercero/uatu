module Uatu
  module Endpoints
    module Single

      Uatu::RESOURCES.each do |resource|
        # example: GET /v1/public/characters/{characterId} => Uatu::Base.new.character
        define_method resource do |id, options={}|
          raise Uatu::Error::BadRequest.new('options must be in a Hash') unless options.is_a?(Hash)
          options.merge!("#{resource}_id".to_sym => id)
          connection = Uatu::Connection.new resource, options
          request_and_build(connection).first
        end
      end

    end
  end
end