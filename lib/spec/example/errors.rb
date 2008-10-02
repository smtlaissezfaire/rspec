module Spec
  module Example
    class ExamplePendingError < StandardError
      def initialize(a_message=nil)
        super
        @pending_caller = caller[2]
      end
      
      attr_reader :pending_caller
    end
    
    class DefaultPendingError < ExamplePendingError
      RSPEC_ROOT = File.expand_path(File.dirname(__FILE__) + "/../../../")
      
      def initialize(call_stack, message = nil)
        super(message)
        @call_stack = call_stack
        @pending_caller = find_pending_caller
      end
      
      attr_reader :call_stack
      
    private
      
      def find_pending_caller
        @call_stack.detect { |trace| !trace.include?(RSPEC_ROOT) }
      end
    end

    class PendingExampleFixedError < StandardError
    end
  end
end
