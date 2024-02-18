# frozen_string_literal: true

module CreateSubscription
  class EntryPoint < BaseEntryPoint

    def initialize(params)
      @contract = Contract.new(params: params)
      @action = Action.new(@contract)
    end

  end
end
