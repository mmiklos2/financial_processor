# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_240_218_153_221) do
  create_table 'invoices', force: :cascade do |t|
    t.string 'state', default: 'unpaid', null: false
    t.integer 'user_id', null: false
    t.integer 'subscription_id', null: false
    t.string 'stripe_customer_id', null: false
    t.string 'stripe_subscription_id', null: false
    t.string 'stripe_invoice_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['subscription_id'], name: 'index_invoices_on_subscription_id'
    t.index ['user_id'], name: 'index_invoices_on_user_id'
  end

  create_table 'stripe_events', force: :cascade do |t|
    t.string 'stripe_event_id', null: false
    t.string 'event_type', null: false
    t.text 'event_json', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'subscriptions', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'stripe_customer_id', null: false
    t.string 'state', default: 'unpaid', null: false
    t.string 'plan_name'
    t.string 'stripe_subscription_id', null: false
    t.date 'start_date', null: false
    t.date 'end_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_subscriptions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'name'
    t.string 'stripe_customer_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'invoices', 'subscriptions'
  add_foreign_key 'invoices', 'users'
  add_foreign_key 'subscriptions', 'users'
end
