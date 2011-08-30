require 'spec_helper'
require 'ostruct'

describe TM4B::Client do

   before do
      TM4B.config.username = "foo"
      TM4B.config.password = "bar"
      TM4B.config.use_ssl  = true

      @success_response = <<-EOS
         <result>
            <broadcastid>MT0017295001</broadcastid>
            <recipients>1</recipients>
            <balancetype>GBP</balancetype>
            <credits>5.0</credits>
            <balance>5995.0</balance>
            <neglected>-</neglected>
         </result>
      EOS

      FakeWeb.register_uri :post, TM4B::Client::BaseURI.dup, :body => @success_response
   end

   it 'should use the appropriate base url' do
      TM4B::Client::BaseURI.should be_a URI
      TM4B::Client::BaseURI.to_s.should == "https://www.tm4b.com:80/client/api/http.php"
   end

   it 'should accept options for an overridden username, password and ssl' do
      default_client = TM4B::Client.new
      default_client.username.should == "foo"
      default_client.password.should == "bar"
      default_client.use_ssl.should == true

      overridden_client = TM4B::Client.new :username => "one", :password => "two", :use_ssl => false
      overridden_client.username.should == "one"
      overridden_client.password.should == "two"
      overridden_client.use_ssl.should  == false
   end

   it 'should broadcast a message, returning a receipt' do
      client = TM4B::Client.new
      result = client.broadcast "+1 213 555-0100", "tm4bsuite", "hello world"
      result.should be_a TM4B::Broadcast
   end

   it 'should raise a service error when receiving an error response' do
      response = OpenStruct.new(:body => "error(0002|Invalid Username or Password)")

      client = TM4B::Client.new
      client.should_receive(:request).and_return response

      lambda do
         client.broadcast "+1 213 555-0100", "tm4bsuite", "hello world"
      end.should raise_error TM4B::ServiceError, "The account's credentials could not be verified"
   end

end