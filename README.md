# README

* Ruby version
  * 3.2.2

* System dependencies
  * Redis
  * Sidekiq

* Configure stripe
  * To use stripe, you need to have a stripe account. You can create one [here](https://stripe.com/)
  * Fetch the API test key from https://dashboard.stripe.com/test/apikeys `(sk_test_...)`
      * This will be added to the credentials file
  * Install stripe CLI from [here](https://stripe.com/docs/stripe-cli)
      * This will be used to listen to stripe webhooks
      * Once installed, run `stripe listen --forward-to localhost:3000/stripe/process_webhook`
          * Copy the webhook key the CLI returns `(whsec_...)`
          * This will be added to the credentials file

* Configuration
  * `bundle install` in the root directory
  * `bin/rails db:migrate` in the root directory
  * `EDITOR="vim" bin/rails credentials:edit` in the root directory
      * Add the stripe secret key and webhook key to the credentials file
        * `stripe_api_key: sk_test_...`
        * `webhook_signing_key: whsec_...`

* How to run the test suite
  * `bundle exec rspec` in the root directory

* Services (job queues, cache servers, search engines, etc.)
  * Sidekiq
    * `bundle exec sidekiq` in the root directory
  * Redis
    * `redis-server -p 6379` in the root directory 

* Deployment instructions
  * `bundle exec rails server` in the root directory
  * By running the above command, the application will be available at `localhost:3000`
  * To run the test to create a subscription, you can use `stripe trigger customer.subscription.created` in the stripe CLI
