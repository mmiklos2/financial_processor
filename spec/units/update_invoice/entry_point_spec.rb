# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateInvoice::EntryPoint do
  subject { described_class.call(params) }

  let(:user) { create(:user, stripe_customer_id:) }
  let(:subscription) { create(:subscription, stripe_subscription_id:) }
  let(:stripe_subscription_id) { 'sub_123' }
  let(:stripe_customer_id) { 'cus_123' }
  let(:invoice) { create(:invoice, stripe_invoice_id:, subscription:, stripe_subscription_id:) }
  let(:state) { 'finalized' }
  let(:stripe_invoice_id) { 'inv_123' }
  let(:params) { { stripe_invoice_id:, state: } }

  before do
    user
    invoice
  end

  context 'with valid params' do
    it 'updates invoice state' do
      expect(subject).to have_attributes(
        state:,
        stripe_invoice_id:
      )
    end
  end

  context 'with invalid params' do
    let(:params) { { stripe_invoice_id: nil } }

    it 'raises an error' do
      expect { subject }.to raise_error(Errors::ValidationError)
    end
  end
end
