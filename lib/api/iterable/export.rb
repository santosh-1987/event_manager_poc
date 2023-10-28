# frozen_string_literal: true

module Api
  module Iterable
    class Export
      @base_uri = "https://api.iterable.com/"

      def self.data(params = {}, type: :csv)
        response = if ActiveModel::Type::Boolean.new.cast(ENV['STUB']) == true
                     Api::Connection.connect_with_stub(@base_uri).get("/api/export/data.#{type}", params)
                   else
                     Api::Connection.connect_with_api_key(@base_uri).get("/api/export/data.#{type}", params)
                   end
        Api::ErrorHandler.return_response(response)
      end
    end
  end

end
