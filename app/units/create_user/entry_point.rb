# frozen_string_literal: true

module CreateUser
  class EntryPoint < BaseEntryPoint

    def initialize(params)
      @contract = CreateUser::Contract.new(params: params)
      @action = Action.new(@contract)
    end

  end
end
