# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    association :user
    association :subscription
    stripe_customer_id { user.stripe_customer_id }
    stripe_subscription_id { subscription.stripe_subscription_id }
    sequence(:stripe_invoice_id) { |n| "stripe_invoice_#{n}" }
    state { 'unpaid' }
  end
end
