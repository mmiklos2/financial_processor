class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :state, null: false, default: 'unpaid'
      t.references :user, null: false, foreign_key: true, index: { name: :index_invoices_on_user_id }
      t.references :subscription, null: false, foreign_key: true, index: { name: :index_invoices_on_subscription_id }
      t.string :stripe_customer_id, null: false
      t.string :stripe_subscription_id, null: false
      t.string :stripe_invoice_id, null: false

      t.timestamps
    end
  end
end
