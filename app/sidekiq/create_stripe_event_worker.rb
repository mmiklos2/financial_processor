# frozen_string_literal: true

class CreateStripeEventWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(request_body, stripe_signature)
    build_stripe_event(request_body, stripe_signature)
    CreateStripeEvent::EntryPoint.call({
                                         stripe_event_id: stripe_event['id'],
                                         event_type: stripe_event['type'],
                                         event_json: stripe_event['data']['object'].to_json
                                       })
    DispatchStripeEvent::EntryPoint.call({
                                           stripe_object: stripe_event['data']['object'],
                                           event_type: stripe_event['type']
                                         })
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
