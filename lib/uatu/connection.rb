module Uatu
  class Connection

    BASE_URL = "http://gateway.marvel.com"

    def request resource, options
      path   = path_by(resource, options)
      params = params_by(options)

      connection.get path, params
    end

  private

    def connection
      @connection ||= Faraday.new(url: BASE_URL) do |faraday|
        faraday.use Uatu::Response::RaiseMarvelError
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

    def path_by resource, options={}
      route = "/v1/public/#{resource_path(resource)}"
      if resource_id = options["#{resource_path(resource).singularize}_id".to_sym]
        route += "/#{resource_id}"
      end

      # If it is combined, it comes after the '_'
      if resource.split('_').count>1 && combined_path = resource.split('_').last
        route += "/#{combined_path}"
      end

      route
    end

    def params_by options
      params = {}

      # We remove unnecessary keys that should go on the route
      temp_params = options.reject{|key, value| key.to_s.match(/.*_id/)}

      # We change the names, so 'format_type' becomes 'formatType'
      temp_params.each{|key, value| params[key.to_s.camelize(:lower).to_sym] = value }

      # An array should become a string with comma separated values
      params.each{|key, value| params[key] = value.join(',') if value.is_a?(Array) }

      params.merge(mandatory_params)
    end

    # character => characters
    # characters => characters
    # character_comics => characters
    def resource_path resource
      @resource_path ||= resource.split('_').first.pluralize.tap do |path|
        raise Uatu::Error.new('InvalidMethod') unless Uatu::Base::RESOURCES.map(&:pluralize).include?(path)
      end
    end

    def mandatory_params
      {
        :apikey => Uatu.public_key,
        :ts     => current_timestamp,
        :hash   => hash(current_timestamp)
      }
    end

    def current_timestamp
      @ts ||= DateTime.now.to_s
    end

    def hash timestamp
      Digest::MD5.hexdigest("#{timestamp}#{Uatu.private_key}#{Uatu.public_key}")
    end

  end
end
