# frozen_string_literal: true

module UpdateSubscription
  class EntryPoint < BaseEntryPoint
    def initialize(params)
      @contract = Contract.new(params:)
      @action = Action.new(@contract)
    end
  end
end
