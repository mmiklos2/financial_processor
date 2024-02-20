# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DispatchStripeEvent::Action do
  subject { described_class.new(contract).call }

  let(:contract) { DispatchStripeEvent::Contract.new(params:) }
  let(:params) { { event_type:, stripe_object: } }

  context 'when event type is customer.created' do
    let(:event_type) { 'customer.created' }
    let(:stripe_object) { { name: 'John', email: 'john@mail.com', stripe_customer_id: 'stripe_id' } }

    it 'calls CreateUser' do
      expect(CreateUser::EntryPoint).to receive(:call)
      subject
    end
  end

  context 'when event type is customer.subscription.created' do
    let(:event_type) { 'customer.subscription.created' }
    let(:stripe_object) do
      { stripe_customer_id: 'customer_id', stripe_subscription_id: 'sub_id', start_date: Time.zone.today }
    end

    it 'calls CreateSubscription' do
      expect(CreateSubscription::EntryPoint).to receive(:call)
      subject
    end
  end

  context 'when event type is customer.subscription.deleted' do
    let(:event_type) { 'customer.subscription.deleted' }
    let(:stripe_object) { { stripe_subscription_id: 'sub_id', state: 'canceled' } }

    it 'calls UpdateSubscription' do
      expect(UpdateSubscription::EntryPoint).to receive(:call)
      subject
    end
  end

  context 'when event type is invoice.created' do
    let(:event_type) { 'invoice.created' }
    let(:stripe_object) do
      { stripe_customer_id: 'cus_id', stripe_invoice_id: 'inv_id',
        stripe_subscription_id: 'sub_id' }
    end

    it 'calls CreateInvoice' do
      expect(CreateInvoice::EntryPoint).to receive(:call)
      subject
    end
  end

  context 'when event type is invoice.paid' do
    let(:event_type) { 'invoice.paid' }
    let(:stripe_object) { { id: 'inv_id', state: 'paid', subscription: 'sub_id' } }

    it 'calls UpdateInvoice and UpdateSubscription' do
      expect(UpdateInvoice::EntryPoint).to receive(:call)
      expect(UpdateSubscription::EntryPoint).to receive(:call)
      subject
    end
  end

  context 'when event type is invoice.finalized' do
    let(:event_type) { 'invoice.finalized' }
    let(:stripe_object) { { id: 'inv_id', state: 'paid' } }

    it 'calls UpdateInvoice' do
      expect(UpdateInvoice::EntryPoint).to receive(:call)
      subject
    end
  end
end
