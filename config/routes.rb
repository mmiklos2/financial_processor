# frozen_string_literal: true

Rails.application.routes.draw do
  post '/stripe/process_webhook', to: 'stripe#process_webhook'
end
