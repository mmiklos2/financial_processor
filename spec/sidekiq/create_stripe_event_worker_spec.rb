# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe CreateStripeEventWorker, type: :job do
  let(:event) { double('event') }
  let(:data_double) { double('data') }
  let(:event_data) { { 'data' => { 'object' => data_double } } }
  let(:request_body) { 'request_body' }
  let(:stripe_signature) { 'stripe_signature' }

  after { described_class.clear }

  it 'enqueues the job' do
    expect { described_class.perform_async(request_body, stripe_signature) }
      .to change(described_class.jobs, :size).by(1)
  end

  context 'when the Stripe event is valid' do
    before do
      allow(Stripe::Webhook).to receive(:construct_event).and_return(event)
      allow(event).to receive(:[]).with('id').and_return('event_id')
      allow(event).to receive(:[]).with('type').and_return('event_type')
      allow(event).to receive(:[]).with('data').and_return(event_data)
    end

    it 'calls the correct units' do
      expect(CreateStripeEvent::EntryPoint).to receive(:call).once
      expect(DispatchStripeEvent::EntryPoint).to receive(:call).once

      described_class.perform_async(request_body, stripe_signature)
      described_class.drain
    end
  end
end
