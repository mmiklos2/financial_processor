# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }
      t.string :name
      t.string :stripe_customer_id, null: false

      t.timestamps
    end
  end
end
