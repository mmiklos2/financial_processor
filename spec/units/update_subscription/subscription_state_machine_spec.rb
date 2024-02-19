# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateSubscription::SubscriptionStateMachine do
  subject { described_class.new(subscription:, desired_state:).state_change_allowed? }

  let(:subscription) { build(:subscription, state:) }
  let(:state) { 'paid' }
  let(:desired_state) { 'canceled' }

  before { subscription }

  context 'when state change is supported' do
    it { is_expected.to be true }
  end

  context 'when state change is not supported' do
    let(:desired_state) { 'unpaid' }

    it { is_expected.to be false }
  end
end
