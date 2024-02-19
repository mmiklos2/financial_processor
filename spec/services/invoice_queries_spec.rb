# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceQueries do
  describe '.by_stripe_invoice_id' do
    it 'returns the invoice with the given stripe invoice id' do
      invoice = create(:invoice, stripe_invoice_id: 'cus_123')
      expect(InvoiceQueries.by_stripe_invoice_id('cus_123')).to contain_exactly(invoice)
    end
  end
end
