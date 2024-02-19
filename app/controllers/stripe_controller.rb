# frozen_string_literal: true

class StripeController < ApplicationController
  def process_webhook
    body = request.body.read
    Stripe::Webhook::Signature.verify_header(
      body,
      request.env['HTTP_STRIPE_SIGNATURE'],
      Rails.application.credentials.webhook_signing_key
    )
    CreateStripeEventWorker.perform_async(body, request.env['HTTP_STRIPE_SIGNATURE'])
    head :no_content
  rescue Stripe::SignatureVerificationError
    head :bad_request, content_type: 'text/plain', body: 'Invalid Stripe signature'
  end
end
