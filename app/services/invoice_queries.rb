# frozen_string_literal: true

class InvoiceQueries
  class << self
    def by_stripe_invoice_id(stripe_invoice_id)
      Invoice.where(stripe_invoice_id:)
    end
  end
end
