require 'faraday'
require 'uatu/response'

module Uatu
  class Connection

    def request(method, options, conn_options)
      conn = build_connection(conn_options)
      conn_params = prepare_options(options).merge(mandatory_params(conn_options))
      conn_route = build_route(method, options)

      conn.get conn_route, conn_params
    end

  private

    def build_connection(conn_options)
      Faraday.new(url: conn_options.base_url) do |faraday|
        faraday.use Uatu::Response::RaiseMarvelError

        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

    def build_route(method, options={})
      route = "/v1/public/#{valid_method(method)}"
      if resource_id = options["#{valid_method(method).singularize}_id".to_sym]
        route += "/#{resource_id}"
      end

      # If it is combined, it comes after the '_'
      if method.split('_').count>1 && combined_path = method.split('_').last
        route += "/#{combined_path}"
      end

      route
    end

    def prepare_options(options)
      valid_opts = {}

      # We remove unnecessary keys that should go on the route
      _options = options.reject{|key, value| key.to_s.match(/.*_id/)}

      # We change the names, so 'format_type' becomes 'formatType'
      _options.each{|key, value| valid_opts[key.to_s.camelize(:lower).to_sym] = value }

      # An array should become a string with comma separated values
      valid_opts.each{|key, value| valid_opts[key] = value.join(',') if value.is_a?(Array) }

      valid_opts
    end

    # character => characters
    # characters => characters
    # character_comics => characters
    def valid_method(method)
      _method = method.split('_').first.pluralize
      raise Uatu::Error.new('InvalidMethod') unless Uatu::Base::RESOURCES.map(&:pluralize).include?(_method)
      _method
    end

    def current_timestamp
      @ts ||= DateTime.now.to_s
    end

    def hash(timestamp, conn_options)
      Digest::MD5.hexdigest("#{timestamp}#{conn_options.private_key}#{conn_options.public_key}")
    end

    def mandatory_params(conn_options)
      {apikey: conn_options.public_key, ts: current_timestamp, hash: hash(current_timestamp, conn_options)}
    end

  end
end
