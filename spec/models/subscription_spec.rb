# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    subject { create(:subscription, user:) }

    let(:user) { create(:user) }

    it 'has a valid belongs_to association with user' do
      expect(subject).to be_valid
      expect(subject.user).to eq(user)
      expect(subject.user_id).to eq(user.id)
    end
  end
end
