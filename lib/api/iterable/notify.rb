# frozen_string_literal: true

module Api
  module Iterable
    class Notify
      @base_uri = ServiceConfig[:iterable_io_service_uri]

      def self.send_email(params = {})
        response = Api::Connection.connect_with_api_key(
          @base_uri
        ).post('/api/email/target', params)

        response.body
      end
    end
  end
end
