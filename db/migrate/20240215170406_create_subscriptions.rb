# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true, index: { name: :index_subscriptions_on_user_id }
      t.string :stripe_customer_id, null: false
      t.string :stripe_subscription_id, null: false
      t.string :state, null: false, default: 'unpaid'
      t.date :start_date, null: false

      t.timestamps
    end
  end
end
