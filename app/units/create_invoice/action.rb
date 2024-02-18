# frozen_string_literal: true

module CreateInvoice
  class Action

    def initialize(contract)
      @contract = contract
    end

    def call
      invoice = Invoice.new(
        user_id: user.id, stripe_customer_id: params[:stripe_customer_id],
        subscription_id: subscription.id, stripe_subscription_id: params[:stripe_subscription_id],
        stripe_invoice_id: params[:stripe_invoice_id],
        state: 'unpaid',
      )
      invoice.save
      invoice
    end

    private

    attr_reader :contract

    delegate :params, to: :contract, private: true

    def user
      UserQueries.by_stripe_customer_id(params[:stripe_customer_id]).take
    end

    def subscription
      SubscriptionQueries.by_stripe_subscription_id(params[:stripe_subscription_id]).take
    end

  end
end
