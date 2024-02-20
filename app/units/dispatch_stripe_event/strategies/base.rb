# frozen_string_literal: true

module DispatchStripeEvent
  module Strategies
    class Base
      def initialize(stripe_object)
        @stripe_object = stripe_object
      end

      def call
        raise NotImplementedError, 'Subclasses must implement a call method'
      end

      private

      def unit_params
        raise NotImplementedError, 'Subclasses must implement a unit_params method'
      end

      attr_reader :stripe_object
    end
  end
end
