# frozen_string_literal: true

require 'rails_helper'

describe 'Api::Iterable::Export' do
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  # Faraday::Connection object that uses the test adapter
  let(:connection) { Faraday.new { |b| b.adapter(:test, stubs) } }

  # Export with the stubbed connection object injected
  let(:client) { described_class.new(connection) }
  # This allows for each test to have its own set of stubs


  before do
    allow(Api::Connection).to receive(:connect_with_api_key).and_return(connection)
  end

  after do
    Faraday.default_connection = nil
  end

  describe '#csv' do
    context 'when an csv is passed' do

      it 'gets the Export' do
        stubs.get('/api/export/data.csv') do
          [
            200,
            { 'Content-Type': 'application/json' },
            '{"location":"Paris"}'
          ]
        end
        api_res = Api::Iterable::Export.data
        expect(api_res).to eq('{"location":"Paris"}')
        stubs.verify_stubbed_calls
      end
    end
  end
end
