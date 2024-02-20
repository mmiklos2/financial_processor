# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    association :user
    stripe_customer_id { user.stripe_customer_id }
    state { 'unpaid' }
    sequence(:stripe_subscription_id) { |n| "stripe_subscription_#{n}" }
    start_date { Time.zone.today }
  end
end
