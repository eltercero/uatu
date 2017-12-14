module Uatu
  module Endpoints
    module Collection

      Uatu::RESOURCES.each do |resource|
        # example: GET /v1/public/characters => Uatu::Base.new.characters
        define_method resource.pluralize do |options={}|
          raise Uatu::Error::BadRequest.new('options must be in a Hash') unless options.is_a?(Hash)
          connection = Uatu::Connection.new resource, options
          request_and_build connection
        end
      end

    end
  end
end