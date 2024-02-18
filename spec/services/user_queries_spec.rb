# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserQueries do
  describe '.by_stripe_customer_id' do
    it 'returns the user with the given stripe customer id' do
      user = create(:user, stripe_customer_id: 'cus_123')
      expect(UserQueries.by_stripe_customer_id('cus_123')).to contain_exactly(user)
    end
  end
end
