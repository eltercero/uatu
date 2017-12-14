module Uatu
  class Base
    include Uatu::Endpoints::Single
    include Uatu::Endpoints::Collection
    include Uatu::Endpoints::Nested

    attr_accessor :last_request_url

  private

    def request_and_build connection
      response = connection.request
      parsed_body = JSON.parse(response.body)

      @last_request_url = response.to_hash[:url].to_s

      output = parsed_body['data']['results'].map do |resource_hash|
        "Uatu::#{connection.resource.split('_').last.classify}".constantize.new(resource_hash)
      end

      output
    end

  end
end
