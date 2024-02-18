# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateInvoice::EntryPoint do
  subject { described_class.call(params) }

  let(:user) { create(:user, stripe_customer_id:) }
  let(:subscription) { create(:subscription, stripe_subscription_id:) }
  let(:state) { 'unpaid' }
  let(:stripe_subscription_id) { 'sub_123' }
  let(:stripe_customer_id) { 'cus_123' }
  let(:stripe_invoice_id) { 'inv_123' }
  let(:params) { { stripe_subscription_id:, stripe_customer_id:, stripe_invoice_id: } }

  before do
    user
    subscription
  end

  context 'with valid params' do
    it 'creates a new invoice' do
      expect(subject).to have_attributes(
        state:,
        user_id: user.id,
        stripe_customer_id:,
        subscription_id: subscription.id,
        stripe_subscription_id:,
        stripe_invoice_id:
      )
    end
  end
end
