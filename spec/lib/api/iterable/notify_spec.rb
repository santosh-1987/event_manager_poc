# frozen_string_literal: true

require 'rails_helper'
require 'api/iterable/notify'

describe 'Api::Iterable::Notify' do
  let(:query_id) { '4' }
  let(:connection) { double }
  let(:response) { double(body: { data: 'Scheduled' }) }

  before do
    allow(Api::Connection).to receive(:connect_with_api_key).and_return(connection)
  end

  describe '#send_email' do
    let(:notify_params) { { email: 'xyz@gmail.com' } }
    context 'when query params are passed' do
      before do
        allow(connection).to receive(:post).with('/api/email/target', notify_params).and_return(response)
      end

      it 'creates the Notification' do
        expect(Api::Iterable::Notify.send_email(notify_params)).to eq(response.body)
      end
    end
  end
end
