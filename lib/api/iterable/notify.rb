# frozen_string_literal: true

module Api
  module Iterable
    class Notify
      @base_uri = ServiceConfig[:iterable_io_service_uri]

      def self.send_email(params = {})
        response = if ActiveModel::Type::Boolean.new.cast(ENV['STUB']) == true

                     Api::Connection.connect_with_stub(
                       @base_uri
                     ).post('/api/email/target', params)
                   else
                     Api::Connection.connect_with_api_key(
                       @base_uri
                     ).post('/api/email/target', params)
                   end

        response.body
      end
    end
  end
end
