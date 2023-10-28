# frozen_string_literal: true

module Api
  module Iterable
    class Export
      @base_uri = "https://api.iterable.com/"

      def self.data(params = {}, type: :csv)
        response = Api::Connection.connect_with_api_key(@base_uri).get("/api/export/data.#{type}", params)

        Api::ErrorHandler.return_response(response)
      end
    end
  end
end
