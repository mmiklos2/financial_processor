# frozen_string_literal: true

module DispatchStripeEvent
  module Strategies
    class InvoiceFinalized < Base
      def call
        UpdateInvoice::EntryPoint.call(unit_params(stripe_object))
      end

      private

      def unit_params(stripe_object)
        {
          stripe_invoice_id: stripe_object['id'],
          state: stripe_object['status']
        }.compact_blank
      end
    end
  end
end
