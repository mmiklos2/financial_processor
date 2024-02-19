# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateStripeEventWorker, type: :job do
  let(:event) { double('event') }

  it 'enqueues the job' do
    expect { described_class.perform_later(event) }.to have_enqueued_job(described_class)
  end
end
