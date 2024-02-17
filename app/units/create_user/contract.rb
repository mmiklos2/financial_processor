# frozen_string_literal: true

module CreateUser
  class Contract < BaseContract

    schema do
      required(:name).filled(:string)
      required(:email).filled(:string)
      required(:stripe_customer_id).filled(:string)
    end

    rule(:email) do
      key.failure(:format?) unless value.match? URI::MailTo::EMAIL_REGEXP
    end

  end
end
