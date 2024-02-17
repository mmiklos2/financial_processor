# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    association :user
    sequence(:plan_name) { |n| "Arthur Pendragon #{n}" }
    state { 'active' }
    sequence(:stripe_subscription_id) { |n| "stripe_id_#{n}" }
    start_date { Time.zone.today }
    end_date { Time.zone.today + 1.month }
  end
end
