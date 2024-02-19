# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseEntryPoint do
  let(:klass) do
    Class.new(BaseEntryPoint) do
      def initialize(contract, action, params)
        @params = params
        self.contract = contract.new(params:)
        self.action = action
      end

      attr_reader :params
    end
  end

  let(:fake_contract_class) do
    Class.new(BaseContract) do
      json do
        required(:integer_field).filled(:integer)
      end

      rule(:integer_field) do
        key.failure('must be greater than 2') if value <= 2
      end
    end
  end

  describe '#call' do
    subject { klass.call(contract, action, params) }

    let(:contract) { fake_contract_class }
    let(:action) { double }
    let(:params) { { integer_field: 3 } }

    before do
      allow(action).to receive(:call)
    end

    it 'validates contract and calls an action' do
      subject
      expect(action).to have_received(:call)
    end

    context 'when contract validation fails' do
      let(:params) { { integer_field: 1 } }

      it "doesn't call action and raises an error" do
        expect(action).not_to receive(:call)
        expect { subject }.to raise_error(Errors::ValidationError)
      end
    end
  end
end
