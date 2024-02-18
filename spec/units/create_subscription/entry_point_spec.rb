# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateSubscription::EntryPoint do
  subject { described_class.call(params) }

  let(:user) { create(:user) }
  let(:state) { 'unpaid' }
  let(:stripe_subscription_id) { 'sub_123' }
  let(:start_date) { 1708292157 }
  let(:params) { { stripe_subscription_id:, start_date:, stripe_customer_id: user.stripe_customer_id } }

  before { user }

  context 'with valid params' do
    it 'creates a new subscription' do
      expect(subject).to have_attributes(
        state:,
        user_id: user.id,
        stripe_subscription_id:,
        start_date: Time.at(start_date).to_date
      )
    end
  end

  context 'with invalid params' do
    let(:start_date) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error(Errors::ValidationError, { start_date: ['must be an integer'] }.to_s)
    end

  end
end
