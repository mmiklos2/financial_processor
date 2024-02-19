# frozen_string_literal: true

class CreateStripeEventWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(request_body, stripe_signature)
    build_stripe_event(request_body, stripe_signature)
    CreateStripeEvent::EntryPoint.call(
      {
        stripe_event_id: stripe_event['id'],
        event_type: stripe_event['type'],
        event_json: stripe_event['data']['object'].to_json
      }
    )
    dispatch_event
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

  def dispatch_event
    # TODO: create a unit to handle this logic
    stripe_object = stripe_event['data']['object']
    case stripe_event['type']
    when 'customer.created'
      CreateUser::EntryPoint.call(user_pFarams(stripe_object))
    when 'customer.subscription.created'
      CreateSubscription::EntryPoint.call(subscription_params(stripe_object))
    when 'invoice.created'
      CreateInvoice::EntryPoint.call(created_invoice_params(stripe_object))
    when 'invoice.paid'
      UpdateInvoice::EntryPoint.call(state_changed_invoice_params(stripe_object))
      UpdateSubscription::EntryPoint.call(stripe_subscription_id: stripe_object['subscription'], state: 'paid')
    when 'invoice.finalized'
      UpdateInvoice::EntryPoint.call(state_changed_invoice_params(stripe_object))
    when 'customer.subscription.deleted'
      UpdateSubscription::EntryPoint.call(stripe_subscription_id: stripe_object['id'], state: 'canceled')
    end
  end

  def user_params(stripe_customer)
    {
      name: stripe_customer['name'],
      email: stripe_customer['email'],
      stripe_customer_id: stripe_customer['id']
    }.compact_blank
  end

  def subscription_params(stripe_subscription)
    {
      stripe_customer_id: stripe_subscription['customer'],
      stripe_subscription_id: stripe_subscription['id'],
      plan_name: stripe_subscription['items']['data'][0]['plan']['nickname'],
      start_date: stripe_subscription['start_date']
    }.compact_blank
  end

  def created_invoice_params(stripe_invoice)
    {
      stripe_customer_id: stripe_invoice['customer'],
      stripe_invoice_id: stripe_invoice['id'],
      stripe_subscription_id: stripe_invoice['subscription'],
      amount_due: stripe_invoice['amount_due']
    }.compact_blank
  end

  def state_changed_invoice_params(stripe_invoice)
    {
      stripe_invoice_id: stripe_invoice['id'],
      state: stripe_invoice['status']
    }.compact_blank
  end
end
