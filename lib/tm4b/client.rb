module TM4B
   class Client
      BaseURI = URI.parse("https://www.tm4b.com:80/client/api/http.php").freeze

      attr_accessor :username, :password, :use_ssl

      def initialize(options={})
         @username = options.fetch(:username, TM4B.config.username)
         @password = options.fetch(:password, TM4B.config.password)
         @use_ssl  = options.fetch(:use_ssl,  TM4B.config.use_ssl)
      end

      def broadcast(recipients, originator, message, options={})
         broadcast = Broadcast.new
         broadcast.recipients = recipients
         broadcast.originator = originator
         broadcast.message    = message

         response = request(broadcast.parameters)

         broadcast
      end

   private

      def request(params)
         req = Net::HTTP::Post.new(BaseURI.path)
         
         req.set_form_data params.merge(:username => username, :password => password)
         
         conn = Net::HTTP.new(BaseURI.host, BaseURI.port)
         conn.use_ssl = use_ssl
         conn.start {|http| http.request(req) }
      end
   end
end