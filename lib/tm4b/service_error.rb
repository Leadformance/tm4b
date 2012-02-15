# encoding: utf-8
module TM4B
   class ServiceError < StandardError
      attr_reader :code
      def initialize(code, message)
         super(message)
         @code = code
      end
   end
end