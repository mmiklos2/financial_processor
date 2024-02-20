# frozen_string_literal: true

module DispatchStripeEvent
  module Strategies
    class CustomerCreated < Base
      def call
        CreateUser::EntryPoint.call(unit_params(stripe_object))
      end

      private

      def unit_params(stripe_object)
        {
          name: stripe_object[:name],
          email: stripe_object[:email],
          stripe_customer_id: stripe_object[:id]
        }.compact_blank
      end
    end
  end
end
