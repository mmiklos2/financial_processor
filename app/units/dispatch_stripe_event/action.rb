# frozen_string_literal: true

module DispatchStripeEvent
  class Action
    def initialize(contract)
      @contract = contract
    end

    def call
      "DispatchStripeEvent::Strategies::#{params[:event_type].gsub('.', '_').classify}"
        .constantize.new(params[:stripe_object]).call
    end

    private

    attr_reader :contract

    delegate :params, to: :contract, private: true
  end
end
