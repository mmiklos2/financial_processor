# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateUser::EntryPoint do
  subject { described_class.call(params) }

  let(:name) { 'John Doe' }
  let(:email) { 'john.doe@mail.com' }
  let(:stripe_customer_id) { 'cus_123' }
  let(:params) { { name:, email:, stripe_customer_id: } }

  context 'with valid params' do
    it 'creates a new user' do
      expect(subject).to have_attributes(name:, email:, stripe_customer_id:)
    end
  end

  context 'with invalid params' do
    let(:email) { 'invalid_email' }

    it 'raises an error' do
      expect { subject }.to raise_error(Errors::ValidationError)
    end
  end
end
