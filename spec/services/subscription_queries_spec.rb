# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionQueries do
  describe '.by_stripe_subscription_id' do
    it 'returns the subscription with the given stripe customer id' do
      subscription = create(:subscription, stripe_subscription_id: 'cus_123')
      expect(SubscriptionQueries.by_stripe_subscription_id('cus_123')).to contain_exactly(subscription)
    end
  end
end
