# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateSubscription::EntryPoint do
  subject { described_class.call(params) }

  let(:subscription) { create(:subscription, stripe_subscription_id:, state:) }
  let(:state) { 'paid' }
  let(:new_state) { 'canceled' }
  let(:stripe_subscription_id) { 'inv_123' }
  let(:params) { { stripe_subscription_id:, state: new_state } }

  before { subscription }

  context 'with valid params' do
    it 'creates a new subscription' do
      expect(subject).to have_attributes(
        state: 'canceled',
        stripe_subscription_id:
      )
    end

    context 'when subscription state change is not supported' do
      let(:state) { 'unpaid' }

      it 'raises an error' do
        expect { subject }.to raise_error(/State change not allowed for subscription/)
      end
    end
  end

  context 'with invalid params' do
    let(:params) { { stripe_subscription_id: nil, state: } }

    it 'raises an error' do
      expect { subject }.to raise_error(Errors::ValidationError)
    end
  end
end
