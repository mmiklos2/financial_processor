# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    subject { create(:invoice, user:, subscription:) }

    let(:user) { create(:user) }
    let(:subscription) { create(:subscription) }

    it 'has a valid belongs_to association with user' do
      expect(subject).to be_valid
      expect(subject.user).to eq(user)
      expect(subject.user_id).to eq(user.id)
      expect(subject.subscription).to eq(subscription)
      expect(subject.subscription_id).to eq(subscription.id)
    end
  end
end
