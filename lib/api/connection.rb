# frozen_string_literal: true

module Api
  # Module for classes interacting with APIs
  module Connection
    class << self
      # :ignore_coverage:

      # returns the connection object for the named API
      # Input: url to connect to
      def connect_with_api_key(url)
        Faraday.new(
          url: url,
          request: { params_encoder: Faraday::FlatParamsEncoder }
        ) do |conn|
          conn.request :authorization, :Bearer, ServiceConfig[:iterable_api_token]

          conn.request :json
          conn.response :json,
                        content_type: 'application/json',
                        parser_options: { symbolize_names: true }
          conn.headers = {
            'Content-Type' => 'application/json; charset=UTF-8',
            'Accept' => 'application/json'
          }.merge!('Api-Key': ServiceConfig[:iterable_api_token])
          conn.options.timeout = ServiceConfig[:read_timeout_default].to_i
          conn.options.open_timeout = ServiceConfig[:open_timeout_default].to_i
          conn.use Faraday::Response::RaiseError
        end
      end

      def connect_with_stub(url)
        stubs = Faraday::Adapter::Test::Stubs.new
        conn = Faraday.new { |b| b.adapter(:test, stubs) }
        stubs.get('http:/api/export/data.csv') do
          [
            200,
            { 'Content-Type': 'application/json' },
            '{"data": "Stubbed response for testing"}'
          ]
        end
        stubs.post('http:/api/email/target') do
          [
            200,
            { 'Content-Type': 'application/json' },
            '{"data": "Stubbed response for testing"}'
          ]
        end
        conn
      end

      private

      def stubbed_connection(url) end
    end
  end
end
