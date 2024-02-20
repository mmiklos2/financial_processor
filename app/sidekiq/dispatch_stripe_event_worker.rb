# frozen_string_literal: true

class DispatchStripeEventWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(request_body, stripe_signature)
    build_stripe_event(request_body, stripe_signature)
    DispatchStripeEvent::EntryPoint.call({
                                           stripe_object: stripe_event['data']['object'].to_h,
                                           event_type: stripe_event['type']
                                         })
  rescue Errors::ValidationError
    Rails.logger.info('Event currently unsupported')
  end

  private

  attr_reader :stripe_event

  def build_stripe_event(request_body, stripe_signature)
    @stripe_event = Stripe::Webhook.construct_event(
      request_body,
      stripe_signature,
      Rails.application.credentials.webhook_signing_key
    )
  end
end
