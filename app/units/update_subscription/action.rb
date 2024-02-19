# frozen_string_literal: true

module UpdateSubscription
  class Action
    def initialize(contract)
      @contract = contract
    end

    def call
      if state_change_allowed?
        subscription.update(state: params[:state])
        subscription
      else
        raise "State change not allowed for subscription #{subscription.stripe_subscription_id} from "\
              "#{subscription.state} to #{params[:state]}"
      end
    end

    private

    attr_reader :contract

    delegate :params, to: :contract, private: true

    def subscription
      @subscription ||= SubscriptionQueries.by_stripe_subscription_id(params[:stripe_subscription_id]).take
    end

    def state_change_allowed?
      SubscriptionStateMachine.new(subscription:, desired_state: params[:state]).state_change_allowed?
    end
  end
end
