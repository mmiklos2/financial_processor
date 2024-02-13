# frozen_string_literal: true

class StripeController < ApplicationController
  def process_webhook
    head :no_content
  end
end
