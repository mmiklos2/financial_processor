# frozen_string_literal: true

module CreateStripeEvent
  class Action
    def initialize(contract)
      @contract = contract
    end

    def call
      stripe_event = StripeEvent.new(
        stripe_event_id: params[:stripe_event_id],
        event_type: params[:event_type],
        event_json: params[:event_json]
      )
      stripe_event.save
      stripe_event
    end

    private

    attr_reader :contract

    delegate :params, to: :contract, private: true
  end
end
