# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StripeController, type: :controller do
  describe 'POST #webhook' do
    context 'when the Stripe signature is invalid' do
      before do
        allow(Stripe::Webhook::Signature).to receive(:verify_header)
          .and_raise(Stripe::SignatureVerificationError.new('', ''))
      end

      it 'returns a 400 status' do
        post :process_webhook
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the Stripe signature is valid' do
      before do
        allow(Stripe::Webhook::Signature).to receive(:verify_header).and_return(true)
        expect(CreateStripeEventWorker).to receive(:perform_async).once
      end

      it 'returns a 200 status' do
        post :process_webhook
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
