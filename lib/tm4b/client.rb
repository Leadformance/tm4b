# encoding: utf-8

require 'net/http'
require 'net/https'

module TM4B
   class Client
      BaseURI = URI.parse("http://www.tm4b.com/client/api/http.php").freeze

      attr_accessor :username, :password, :use_ssl

      def initialize(options={})
         @username = options.fetch(:username, TM4B.config.username)
         @password = options.fetch(:password, TM4B.config.password)
         @use_ssl  = options.fetch(:use_ssl,  TM4B.config.use_ssl)
      end

      #
      # Broadcasts an SMS message to a recipient.
      #
      # @param [String|Array] recipients The MSISDN (sms number) for the recipients
      # 
      # @param [String] originator The string used for the sender name, must be
      #   between 1 and 11 characters (inclusive)
      #
      # @param [String] message The content of the message
      #
      # @param [Hash] options Optional values when sending this message
      #
      # @option options [Boolean] :simulated (false) makes the broadcast not
      #   deliver but simulates what the result would be 
      # 
      # @option options [Fixnum] :split_method (:concatenation_graceful) Defines
      #   which split method the service will use when sending very long messages
      #   to the recipient that exceed the single message maximum length.  The
      #   value passed must be a key of the Tm4b::Protocol::SplitMethods hash.
      #
      # @option options [String] :route (nil) Defines which delivery route to
      #   use when sending this message.  See the TM4b API docs for details.
      #
      # @option options [String] :encoding ("unicode") Defines which encoding to
      #   use when sending this message.  Use either "unicode" or "plain" or nil
      #
      def broadcast(recipients, originator, message, options={})
         broadcast = Broadcast.new
         broadcast.recipients = recipients
         broadcast.originator = originator
         broadcast.message    = message

         
         broadcast.simulated = true if options[:simulated]
         broadcast.split_method = options[:split_method] if options[:split_method]
         broadcast.route = options[:route] if options[:route]
         broadcast.encoding = options[:encoding] if options[:encoding]

         response = request(broadcast.parameters)

         raise_if_service_error(response.body)

         broadcast.raw_response = response.body

         broadcast
      end

      #
      # Queries the TM4B server for the current balance of the SMS account.
      #
      def check_balance
         check = BalanceCheck.new

         response = request(check.parameters)

         raise_if_service_error(response.body)

         check.raw_response = response.body

         check
      end

      #
      # Queries the TM4B server for the status of a sms message delivery.  Two
      # options are given but at least one must be provided.
      #
      # @param [Hash] options
      # @option options [String] :sms_id Search option using sms id
      # @option options [String] :custom_data Search option using custom data
      #
      def check_status(options)
        check = StatusCheck.new(options)

        raise ArgumentError, "either :sms_id or :custom_data is required" if !check.valid?

        response = request(check.parameters)

        raise_if_service_error(response.body)

        check.raw_response = response.body

        check
      end

   private

      def request(params)
         req = Net::HTTP::Post.new("/client/api/http.php")
         
         req.set_form_data params.merge(:username => username, :password => password)
         
         conn = Net::HTTP.new("www.tm4b.com", use_ssl ? 443 : 80)
         conn.use_ssl = use_ssl
         conn.start {|http| http.request(req) }
      end

      def raise_if_service_error(body)
         return unless body =~ /^error\((\d+)\|(.+)\)$/
         
         code = $1.to_i
         message = $2

         raise TM4B::ServiceError.new(code, message)
      end
   end
end
