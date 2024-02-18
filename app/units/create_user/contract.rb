# frozen_string_literal: true

module CreateUser
  class Contract < BaseContract

    schema do
      optional(:name).filled(:string)
      optional(:email).filled(:string)
      required(:stripe_customer_id).filled(:string)
    end

    rule(:email) do
      key.failure(:format?) if value && !value.match?(URI::MailTo::EMAIL_REGEXP)
    end

  end
end
