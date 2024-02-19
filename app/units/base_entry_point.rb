# frozen_string_literal: true

class BaseEntryPoint
  class << self
    def call(...)
      new(...).call
    end
  end

  def call
    validate_params!
    action.call
  end

  private

  attr_accessor :contract, :action

  def validate_params!
    raise_validation_error if invalid_contract?
  end

  def raise_validation_error
    raise Errors::ValidationError, validation_errors
  end

  def invalid_contract?
    contract ? validation_result.failure? : false
  end

  def validation_result
    @validation_result ||= contract.call
  end

  def validation_errors
    validation_result.errors.to_h
  end
end
