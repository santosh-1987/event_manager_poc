# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ErrorHandler do
  describe '#return_response' do
    before do
      allow(response)
        .to receive_message_chain(:env, :url, :to_s)
        .and_return('test')
    end

    context 'when status is 200' do
      let(:response) { double(status: 200, body: 'OK') }

      it 'returns the response' do
        expect(Api::ErrorHandler.send(:return_response, response)).to eq(response.body)
      end
    end

    context 'when status is 201' do
      let(:response) { double(status: 201, body: 'OK') }

      it 'returns the body' do
        expect(Api::ErrorHandler.send(:return_response, response)).to eq(response.body)
      end
    end

    context 'when status is 204' do
      context 'and the body is empty' do
        let(:response) { double(status: 204, body: true) }

        it 'returns the true' do
          expect(Api::ErrorHandler.send(:return_response, response)).to be(true)
        end
      end
    end

    context 'when status is 400' do
      let(:response) { double(status: 400, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }.to raise_error(
          Exceptions::BadRequestError
        )
      end
    end

    context 'when status is 401' do
      let(:response) { double(status: 401, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }
          .to raise_error(Exceptions::UnauthorizedRequestError)
      end
    end

    context 'when status is 403' do
      let(:response) { double(status: 403, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }.to raise_error(
          Exceptions::ForbiddenRequestError
        )
      end
    end

    context 'when status is 404' do
      let(:response) { double(status: 404, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }.to raise_error(
          Exceptions::ResourceNotFoundError
        )
      end
    end

    context 'when status is 502' do
      let(:response) { double(status: 502, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }.to raise_error(
          Exceptions::BadGatewayError
        )
      end
    end

    context 'when status is 503' do
      let(:response) { double(status: 503, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }.to raise_error(
          Exceptions::ServiceUnavailableError
        )
      end
    end

    context 'when status is 504' do
      let(:response) { double(status: 504, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }.to raise_error(
          Exceptions::GatewayTimeoutError
        )
      end
    end

    context 'when status is unknown' do
      let(:response) { double(status: 987, body: 'error') }

      it 'raises an error' do
        expect { Api::ErrorHandler.send(:return_response, response) }.to raise_error(
          Exceptions::BadHttpResponseError
        )
      end
    end
  end
end
