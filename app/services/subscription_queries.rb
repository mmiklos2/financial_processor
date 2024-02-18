# frozen_string_literal: true

class SubscriptionQueries

  class << self
    def by_stripe_subscription_id(stripe_subscription_id)
      Subscription.where(stripe_subscription_id:)
    end
  end

end
