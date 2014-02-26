require 'uatu/connection'
require 'uatu/resource'
require 'time'

module Uatu
  class Base
    include Uatu::Connection

    attr_accessor *Configuration::VALID_CONFIG_KEYS
    attr_accessor :last_request_url
    RESOURCES = %w(comic serie character event story creator)

    def initialize
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", Uatu.options[key])
      end
    end

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

      def comics_by_date(date_from,date_to)
        options = {}
        #options["dateRange"] = sanitize(date_from,date_to)
        options["dateRange"] = date_from+','+date_to
        request_and_build("comics", options) 

      end
    end

    def request_and_build(method_name, options)
      response = request(method_name, options, conn_options)
      parsed_body = JSON.parse(response.body)

      self.last_request_url = response.env.url.to_s

      output = parsed_body['data']['results'].map do |resource_hash|
        "Uatu::#{method_name.split('_').last.classify}".constantize.new(resource_hash)
      end

      output 
    end

    def conn_options
      _conn_options = Hashie::Mash.new
      Configuration::VALID_CONFIG_KEYS.each{|key| _conn_options[key] = send(key)}
      _conn_options
    end


  end
end
