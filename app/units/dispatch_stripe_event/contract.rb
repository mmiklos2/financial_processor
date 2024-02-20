# frozen_string_literal: true

module DispatchStripeEvent
  class Contract < BaseContract
    VALID_EVENT_TYPES = %w[customer.created customer.subscription.created invoice.created
                           invoice.paid invoice.finalized customer.subscription.deleted].freeze
    private_constant :VALID_EVENT_TYPES

    schema do
      required(:stripe_object).filled(:hash)
      required(:event_type).filled(:string)
    end

    rule(:event_type) do
      key.failure('Not a valid event type') unless VALID_EVENT_TYPES.include?(value)
    end
  end
end
