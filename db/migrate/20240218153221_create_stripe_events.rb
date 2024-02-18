class CreateStripeEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_events do |t|
      t.string :stripe_event_id, null: false
      t.string :event_type, null: false
      t.text :event_json, null: false

      t.timestamps
    end
  end
end
