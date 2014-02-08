require 'faraday'
require 'uatu/response'

module Uatu
  module Connection
    
    def request(method, options, conn_options)
      conn = build_connection(conn_options)
      conn_params = prepare_options(options).merge(mandatory_params(conn_options))
      conn_route = build_route(method, options)

      conn.get conn_route, conn_params
    end

    def build_connection(conn_options)
      Faraday.new(url: conn_options.base_url) do |faraday|
        faraday.use Uatu::Response::RaiseMarvelError

        faraday.request  :url_encoded             
        faraday.adapter  Faraday.default_adapter  
      end
    end

    def build_route(method, options={})
      route = "/v1/public/#{valid_method(method)}"
      if resource_id = options["#{method.singularize}_id".to_sym]
        route += "/#{resource_id}"
      end
      route
    end

    def prepare_options(options)
      valid_opts = {}
      
      # We remove innecessary keys that should go on the route
      _options = options.reject{|key, value| key.to_s.match(/.*_id/)}

      # We change the names, so 'format_type' becomes 'formatType' 
      _options.each{|key, value| valid_opts[unrubify(key)] = value }

      # An array should become a string with comma separated values
      valid_opts.each{|key, value| valid_opts[key] = value.join(',') if value.is_a?(Array) }

      valid_opts
    end

    def unrubify(name)
      key = name.to_s
      unrubified_key_array = key.split('_')
      unrubified_key_array[1..-1].each(&:capitalize!)
      unrubified_key_array.join.to_sym
    end

    def valid_method(method)
      _method = method.pluralize
      raise 'InvalidMethod' unless %w(characters series creators comics events stories).include?(_method)
      _method
    end

    def current_timestamp
      DateTime.now.to_s
    end

    def hash(timestamp, conn_options)
      Digest::MD5.hexdigest("#{timestamp}#{conn_options.private_key}#{conn_options.public_key}")      
    end

    def mandatory_params(conn_options)
      ts = current_timestamp
      {apikey: conn_options.public_key, ts: ts, hash: hash(ts, conn_options)}
    end

  end
end