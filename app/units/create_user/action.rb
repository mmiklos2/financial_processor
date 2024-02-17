# frozen_string_literal: true

module CreateUser
  class Action

    def initialize(contract)
      @contract = contract
    end

    def call
      user = User.new(name: params[:name], email: params[:email], stripe_customer_id: params[:stripe_customer_id])
      user.save
      user
    end

    private

    attr_reader :contract

    delegate :params, to: :contract, private: true

  end
end
