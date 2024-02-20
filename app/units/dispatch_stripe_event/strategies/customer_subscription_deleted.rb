# frozen_string_literal: true

module DispatchStripeEvent
  module Strategies
    class CustomerSubscriptionDeleted < Base
      def call
        UpdateSubscription::EntryPoint.call(unit_params(stripe_object))
      end

      private

      def unit_params(stripe_object)
        {
          stripe_subscription_id: stripe_object[:id],
          state: 'canceled'
        }.compact_blank
      end
    end
  end
end
