# frozen_string_literal: true

module Api
  # Class for handling all exceptions from Project Public API
  class ErrorHandler
    class << self
      # returns response object if successful, or raises an appropriate exception
      def return_response(response)
        path = response.env.url.to_s

        case response.status
        when 200, 201, 204 then response.body
        when 400
          raise Exceptions::BadRequestError.new(
            path, response.body, response.status
          )
        when 401
          raise Exceptions::UnauthorizedRequestError.new(
            path, response.body, response.status
          )
        when 403
          raise Exceptions::ForbiddenRequestError.new(
            path, response.body, response.status
          )
        when 404
          raise Exceptions::ResourceNotFoundError.new(
            path, response.body, response.status
          )
        when 502
          raise Exceptions::BadGatewayError.new(
            path, response.body, response.status
          )
        when 503
          raise Exceptions::ServiceUnavailableError.new(
            path, response.body, response.status
          )
        when 504
          raise Exceptions::GatewayTimeoutError.new(
            path, response.body, response.status
          )
        else
          raise Exceptions::BadHttpResponseError.new(
            path, response.body, response.status
          )
        end
      end
    end
  end
end
