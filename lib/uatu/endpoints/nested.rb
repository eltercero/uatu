module Uatu
  module Endpoints
    module Nested

      Uatu::RESOURCES.each do |resource|
        # example: GET /v1/public/characters/{characterId}/comics => Uatu::Base.new.character_comics
        RESOURCES.each do |nested_resource|
          unless nested_resource == resource
            define_method "#{resource}_#{nested_resource.pluralize}" do |id, options={}|
              raise Uatu::Error::BadRequest.new('options must be in a Hash') unless options.is_a?(Hash)
              options.merge!("#{resource}_id".to_sym => id)
              resource = "#{resource}_#{nested_resource.pluralize}"
              connection = Uatu::Connection.new resource, options

              request_and_build connection
            end
          end
        end
      end

    end
  end
end