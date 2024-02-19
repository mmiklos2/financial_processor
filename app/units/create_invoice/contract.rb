# frozen_string_literal: true

module CreateInvoice
  class Contract < BaseContract
    schema do
      required(:stripe_invoice_id).filled(:string)
      required(:stripe_subscription_id).filled(:string)
      required(:stripe_customer_id).filled(:string)
    end
  end
end
