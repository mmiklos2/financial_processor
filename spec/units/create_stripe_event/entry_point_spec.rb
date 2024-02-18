# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateStripeEvent::EntryPoint do
  subject { described_class.call(params) }

  let(:stripe_event_id) { 'stripe_event_1' }
  let(:event_type) { 'customer.subscription.created' }
  let(:event_json) { { 'id' => 'FAKE_DATA' }.to_json }
  let(:params) { { stripe_event_id:, event_type:, event_json: } }

  context 'with valid params' do
    it 'creates a new stripe event' do
      expect(subject).to have_attributes(
        event_type:,
        event_json:,
        stripe_event_id:,
      )
    end
  end

  context 'with invalid params' do
    let(:event_json) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error(Errors::ValidationError, { event_json: ['must be a string'] }.to_s)
    end

  end
end
