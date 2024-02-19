# frozen_string_literal: true

class UserQueries
  class << self
    def by_stripe_customer_id(stripe_customer_id)
      User.where(stripe_customer_id:)
    end
  end
end
