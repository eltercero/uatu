module Uatu
  module Response

    class RaiseMarvelError < Faraday::Response::Middleware

      def on_complete(env)
        status  = env[:status]
        body    = env[:body]
        headers = env[:response_headers]

        parsed_body = JSON.parse(body)
        code    = parsed_body['code']
        message = parsed_body['message'] || parsed_body['status']

        unless code.to_i == 200
          raise Uatu::Error::ClientError.new "- Error code: #{code}\n- Message: #{message}\n ", {body: body, headers: headers}
        end

      end

    end

  end
end