# frozen_string_literal: true

module UpdateInvoice
  class Contract < BaseContract
    schema do
      required(:stripe_invoice_id).filled(:string)
      required(:state).filled(:string)
    end
  end
end
