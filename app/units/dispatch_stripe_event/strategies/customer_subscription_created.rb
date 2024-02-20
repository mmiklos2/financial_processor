# frozen_string_literal: true

module DispatchStripeEvent
  module Strategies
    class CustomerSubscriptionCreated < Base
      def call
        CreateSubscription::EntryPoint.call(unit_params(stripe_object))
      end

      private

      def unit_params(stripe_object)
        {
          stripe_customer_id: stripe_object['customer'],
          stripe_subscription_id: stripe_object['id'],
          start_date: stripe_object['start_date']
        }.compact_blank
      end
    end
  end
end
