module Uatu
  class Base
    attr_accessor :last_request_url
    RESOURCES = %w(comic serie character event story creator)

    RESOURCES.each do |method_name|
      # Singular
      # example: GET /v1/public/characters/{characterId} => Uatu::Base.new.character
      define_method method_name do |id, options={}|
        raise Uatu::Error::BadRequest.new('options must be in a Hash') unless options.is_a?(Hash)
        options.merge!("#{method_name}_id".to_sym => id)
        output = request_and_build(method_name, options)
        output.first
      end

      # Plural
      # example: GET /v1/public/characters => Uatu::Base.new.characters
      define_method method_name.pluralize do |options={}|
        raise Uatu::Error::BadRequest.new('options must be in a Hash') unless options.is_a?(Hash)
        request_and_build(method_name, options)
      end

      # Combined
      # example: GET /v1/public/characters/{characterId}/comics => Uatu::Base.new.character_comics
      RESOURCES.each do |combined|
        unless combined == method_name
          define_method "#{method_name}_#{combined.pluralize}" do |id, options={}|
            raise Uatu::Error::BadRequest.new('options must be in a Hash') unless options.is_a?(Hash)
            options.merge!("#{method_name}_id".to_sym => id)
            request_and_build("#{method_name}_#{combined.pluralize}", options)
          end
        end
      end
    end

  private

    def request_and_build(method_name, options)
      response = connection.request(method_name, options)
      parsed_body = JSON.parse(response.body)

      self.last_request_url = response.to_hash[:url].to_s

      output = parsed_body['data']['results'].map do |resource_hash|
        "Uatu::#{method_name.split('_').last.classify}".constantize.new(resource_hash)
      end

      output
    end

    def connection
      @connection ||= Uatu::Connection.new
    end

  end
end
