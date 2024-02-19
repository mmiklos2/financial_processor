# frozen_string_literal: true

module CreateSubscription
  class Action
    def initialize(contract)
      @contract = contract
    end

    def call
      subscription = Subscription.new(
        user_id: user.id, stripe_customer_id: params[:stripe_customer_id],
        state: 'unpaid',
        stripe_subscription_id: params[:stripe_subscription_id],
        plan_name: params[:plan_name],
        start_date: Time.at(params[:start_date])
      )
      subscription.save
      subscription
    end

    private

    attr_reader :contract

    delegate :params, to: :contract, private: true

    def user
      UserQueries.by_stripe_customer_id(params[:stripe_customer_id]).take
    end
  end
end
