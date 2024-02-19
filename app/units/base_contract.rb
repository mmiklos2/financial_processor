# frozen_string_literal: true

class BaseContract < Dry::Validation::Contract
  option :params

  def call
    super(params)
  end
end
