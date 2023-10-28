# frozen_string_literal: true

module Exceptions
  # Public: Common base class for all errors.
  class EventManagerError < StandardError; end

  # Raised when a user is not found
  class UserNotFoundError < StandardError; end

  # Raised when an action was attempted by someone who is not authorized to take it
  class ActionNotAuthorized < EventManagerError
    attr_reader :action, :object

    # create a new instance of this error type
    #
    # message - The exception's message
    # action - the action type that was attempted.
    #   (e.g. view_summary, join, view, clone, edit, publish, delete, change_roles)
    # object - the object the action was attempted on
    #
    # action and object are optional parameters used for auditing the unauthorized attempt
    def initialize(message = 'Action not Authorized', action = nil, object = nil)
      super(message)
      @action = action
      @object = object
    end
  end

  # Raised when there was an error trying to destroy a content
  class DestroyError < EventManagerError; end

  # Raised when a content could not be found
  class ContentNotFound < EventManagerError; end

  class PermissionsError < EventManagerError
    def message
      "Authorization Error"
    end
  end

  class ServiceClientError < StandardError
    attr_reader :status, :path, :body

    def initialize(path, body, status = 500)
      @status = status
      @path = path
      @body = body
    end

    def message
      "status: #{status}\npath: #{path}\n#{body}"
    end
  end

  # Raised when a service returns a 400 (Bad Request)
  class BadRequestError < ServiceClientError
  end

  # Raised when a service returns a 401 (Unauthorized)
  class UnauthorizedRequestError < ServiceClientError
  end

  # Raised when a service returns a 403 (Forbidden)
  class ForbiddenRequestError < ServiceClientError
  end

  # Raised when a service returns a 404 (Not Found)
  class ResourceNotFoundError < ServiceClientError
  end

  class UnprocessableEntityError < ServiceClientError
  end

  class ResourceConflictError < ServiceClientError
  end

  # Raised when a service returns a 500 (Internal Server Error)
  class BadHttpResponseError < ServiceClientError
  end

  # Raised when a service returns a 502 (Bad Gateway)
  class BadGatewayError < ServiceClientError
  end

  # Raised when a service returns a 503 (Service Unavailable)
  class ServiceUnavailableError < ServiceClientError
  end

  # Raised when a service returns a 504 (Gateway Timeout)
  class GatewayTimeoutError < ServiceClientError
  end
end
