Rails.application.routes.draw do
  post '/stripe/process_webhook', to: 'stripe#process_webhook'
end
