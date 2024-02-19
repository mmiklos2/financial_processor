# frozen_string_literal: true

module UpdateSubscription
  class Contract < BaseContract
    schema do
      required(:stripe_subscription_id).filled(:string)
      required(:state).filled(:string)
    end
  end
end
