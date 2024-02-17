# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Arthur Pendragon #{n}" }
    sequence(:email) { |n| "his_email#{n}@camelot.com" }
    sequence(:stripe_customer_id) { |n| "stripe_id_#{n}" }
  end
end
