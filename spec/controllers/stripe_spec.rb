# frozen_string_literal :true

require 'rails_helper'

RSpec.describe StripeController, type: :controller do
  describe 'POST #webhook' do
    it 'returns a 204 status' do
      post :process_webhook
      expect(response).to have_http_status(:no_content)
    end
  end
end
