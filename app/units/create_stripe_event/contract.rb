# frozen_string_literal: true

module CreateStripeEvent
  class Contract < BaseContract
    schema do
      required(:stripe_event_id).filled(:string)
      required(:event_type).filled(:string)
      required(:event_json).filled(:string)
    end
  end
end
