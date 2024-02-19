# frozen_string_literal: true

module UpdateInvoice
  class Action
    def initialize(contract)
      @contract = contract
    end

    def call
      invoice.update(state: params[:state])
      invoice
    end

    private

    attr_reader :contract

    delegate :params, to: :contract, private: true

    def invoice
      @invoice ||= InvoiceQueries.by_stripe_invoice_id(params[:stripe_invoice_id]).take
    end
  end
end
