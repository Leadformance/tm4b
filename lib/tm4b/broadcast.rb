
module TM4B
   class Broadcast
      attr_reader :recipients
      def recipients=(recipients)
         if String === recipients
            recipients = [recipients]
         end

         @recipients = recipients.map {|r| r.gsub(/\D+/, '') }
      end

      attr_reader :originator
      def originator=(originator)
         originator = originator.to_s

         if (1..11).include? originator.length
            @originator = originator
         else
            raise "originator must be between 1 and 11 characters long"
         end
      end

      attr_reader :encoding
      def encoding=(encoding)
         if Protocol::EncodingTypes.include?(encoding)
            @encoding = encoding
         else
            raise "invalid encoding: #{encoding}"
         end
      end

      attr_reader :split_method
      def split_method=(method)
         if Protocol::SplitMethods.keys.include?(method)
            @split_method = method
         else
            raise "invalid splitting method: #{method}"
         end
      end

      attr_accessor :message, :route

      def initialize
         @encoding = :unicode
         @split_method = :concatenation_graceful
      end

      #
      # Returns a presentation of the broadcast variables for transmission to 
      # the TM4B API.  Does not include the username and password variables.
      #
      def parameters
         {
            "version"      => "2.1",
            "type"         => "broadcast",
            "to"           => recipients.join("|"),
            "from"         => originator,
            "msg"          => message,
            "data_type"    => encoding.to_s,
            "split_method" => Protocol::SplitMethods[split_method],
            "route"        => route
         }
      end
   end
end