module Uatu
  class Error < StandardError
    attr_reader :http_headers

    def initialize(message, http_headers={})
      @http_headers = http_headers
      super(message)
    end

  end 

  class Error::ClientError < Uatu::Error; end
  class Error::BadRequest < Uatu::Error; end

end