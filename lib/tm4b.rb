
require File.expand_path("tm4b/protocol", File.dirname(__FILE__))
require File.expand_path("tm4b/service_error", File.dirname(__FILE__))
require File.expand_path("tm4b/client", File.dirname(__FILE__))
require File.expand_path("tm4b/configuration", File.dirname(__FILE__))
require File.expand_path("tm4b/broadcast", File.dirname(__FILE__))
require File.expand_path("tm4b/balance_check", File.dirname(__FILE__))
require File.expand_path("tm4b/status_check", File.dirname(__FILE__))

module TM4B 
   def self.config
      @@config ||= TM4B::Configuration.new
   end
end
