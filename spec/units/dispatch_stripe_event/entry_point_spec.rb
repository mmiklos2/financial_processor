# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DispatchStripeEvent::EntryPoint do
  subject { described_class.call(params) }

  let(:params) { { event_type:, stripe_object: } }

  context 'when event type is customer.created' do
    let(:event_type) { 'customer.created' }
    let(:stripe_object) { { 'name' => 'John', 'email' => 'john@mail.com', 'id' => 'stripe_id' } }

    it 'creates a new user record' do
      expect { subject }.to change(User, :count).by(1)
    end
  end

  context 'when event type is customer.subscription.created' do
    let(:event_type) { 'customer.subscription.created' }
    let(:stripe_object) do
      { 'customer' => user.stripe_customer_id, 'id' => 'sub_id', 'start_date' => Time.zone.today.to_time.to_i }
    end
    let(:user) { create(:user) }

    it 'creates a new subscription' do
      expect { subject }.to change(Subscription, :count).by(1)
    end
  end

  context 'when event type is customer.subscription.deleted' do
    let(:event_type) { 'customer.subscription.deleted' }
    let(:stripe_object) { { 'id' => subscription.stripe_subscription_id, state: 'canceled' } }
    let(:subscription) { create(:subscription, state: 'paid') }

    it 'updates the state of the subscription' do
      expect { subject }.to change { subscription.reload.state }.to('canceled')
    end
  end

  context 'when event type is invoice.created' do
    let(:event_type) { 'invoice.created' }
    let(:stripe_object) do
      { 'customer' => user.stripe_customer_id, 'id' => 'inv_id',
        'subscription' => subscription.stripe_subscription_id }
    end
    let(:subscription) { create(:subscription) }
    let(:user) { create(:user) }

    it 'creates a new invoice' do
      expect { subject }.to change(Invoice, :count).by(1)
      expect(subject).to have_attributes(user_id: user.id, subscription_id: subscription.id)
    end
  end

  context 'when event type is invoice.paid' do
    let(:event_type) { 'invoice.paid' }
    let(:stripe_object) do
      { 'id' => invoice.stripe_invoice_id, 'status' => 'paid', 'subscription' => subscription.stripe_subscription_id }
    end
    let(:subscription) { create(:subscription, state: 'unpaid') }
    let(:invoice) { create(:invoice, state: 'unpaid') }

    it 'updates invoice and subscription state' do
      expect { subject }.to change { subscription.reload.state }.to('paid')
                                                                .and(change { invoice.reload.state }.to('paid'))
    end
  end

  context 'when event type is invoice.finalized' do
    let(:event_type) { 'invoice.finalized' }
    let(:stripe_object) { { 'id' => invoice.stripe_invoice_id, 'status' => 'finalized' } }
    let(:invoice) { create(:invoice, state: 'paid') }

    it 'updates invoice state' do
      expect { subject }.to change { invoice.reload.state }.to('finalized')
      subject
    end
  end
end
