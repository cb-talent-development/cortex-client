module Cortex
  module ClientExceptions
    class ErrorFromResult < StandardError
      attr_accessor :status, :contents, :errors
      def initialize(arg)
        throw ArgumentError.new(msg: "Expected: Cortex::Result, Received: #{arg.class}") unless arg.is_a?(Cortex::Result)
        @status = arg.status
        @errors = arg.errors
        @contents = arg.contents
      end
    end
  end
end
