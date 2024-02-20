# frozen_string_literal: true

class StripeController < ApplicationController
  def process_webhook
    body = request.body.read
    Stripe::Webhook::Signature.verify_header(
      body,
      request.env['HTTP_STRIPE_SIGNATURE'],
      Rails.application.credentials.webhook_signing_key
    )
    enqueue_workers(body, request.env['HTTP_STRIPE_SIGNATURE'])
    head :ok
  rescue Stripe::SignatureVerificationError
    head :bad_request, content_type: 'text/plain', body: 'Invalid Stripe signature'
  end

  private

  def enqueue_workers(body, signature)
    CreateStripeEventWorker.perform_async(body, signature)
    DispatchStripeEventWorker.perform_async(body, signature)
  end
end
