# frozen_string_literal: true

module CreateSubscription
  class Contract < BaseContract

    schema do
      required(:stripe_customer_id).filled(:string)
      required(:stripe_subscription_id).filled(:string)
      optional(:plan_name).filled(:string)
      required(:start_date).filled(:integer)
    end

  end
end

