# frozen_string_literal: true

module DispatchStripeEvent
  module Strategies
    class InvoiceCreated < Base
      def call
        CreateInvoice::EntryPoint.call(unit_params(stripe_object))
      end

      private

      def unit_params(stripe_object)
        {
          stripe_customer_id: stripe_object[:customer],
          stripe_invoice_id: stripe_object[:id],
          stripe_subscription_id: stripe_object[:subscription]
        }.compact_blank
      end
    end
  end
end
