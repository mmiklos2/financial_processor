# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    association :user
    stripe_customer_id { user.stripe_customer_id }
    sequence(:plan_name) { |n| "iPhone #{n}" }
    state { 'unpaid' }
    sequence(:stripe_subscription_id) { |n| "stripe_subscription_#{n}" }
    start_date { Time.zone.today }
    end_date { Time.zone.today + 1.month }
  end
end
