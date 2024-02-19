# frozen_string_literal: true

module UpdateSubscription
  class SubscriptionStateMachine
    POSSIBLE_FORWARD_STATES = { 'unpaid' => ['paid'], 'paid' => ['canceled'] }.freeze
    private_constant :POSSIBLE_FORWARD_STATES

    def initialize(subscription:, desired_state:)
      @subscription = subscription
      @desired_state = desired_state
    end

    def state_change_allowed?
      POSSIBLE_FORWARD_STATES[subscription.state].include?(desired_state)
    end

    private

    attr_reader :subscription, :desired_state
  end
end
