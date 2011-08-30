require File.expand_path(File.join("..", "lib", "tm4b"), File.dirname(__FILE__))
require 'fakeweb'

RSpec.configure do |config|
   config.before :each do
      FakeWeb.allow_net_connect = false
   end
end