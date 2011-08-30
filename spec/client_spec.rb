require 'spec_helper'
require 'ostruct'

describe TM4B::Client do

   before do
      TM4B.config.username = "foo"
      TM4B.config.password = "bar"
      TM4B.config.use_ssl  = true
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

   context "broadcasting a message" do
      before do
         @success_response = <<-EOS
            <result>
               <broadcastID>MT0017295001</broadcastID>
               <recipients>1</recipients>
               <balanceType>GBP</balanceType>
               <credits>5.0</credits>
               <balance>5995.0</balance>
               <neglected>-</neglected>
            </result>
         EOS

         FakeWeb.register_uri :post, TM4B::Client::BaseURI.dup, :body => @success_response
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

      it 'should assign response values on successful response' do
         client = TM4B::Client.new
         result = client.broadcast "+1 213 555-0100", "tm4bsuite", "hello world"
         result.broadcast_id.should == "MT0017295001"
      end

      it 'should assign the simulated flag if defined' do
         client = TM4B::Client.new
         result = client.broadcast "+1 213 555-0100", "tm4bsuite", "hello world", :simulated => true

         result.simulated.should be_true
      end

      it 'should assign the split_method if defined' do
         client = TM4B::Client.new
         result = client.broadcast "+1 213 555-0100", "tm4bsuite", "hello world", :split_method => :no_split

         result.split_method.should == :no_split
      end

      it 'should assign the route if defined' do
         client = TM4B::Client.new
         result = client.broadcast "+1 213 555-0100", "tm4bsuite", "hello world", :route => "GD01"

         result.route.should == "GD01"
      end

      it 'should assign the encoding if defined' do
         client = TM4B::Client.new
         result = client.broadcast "+1 213 555-0100", "tm4bsuite", "hello world", :encoding => :plain

         result.encoding.should == :plain
      end
   end

   context "checking balance" do
      before do
         @success_response = <<-EOS
            <result>
               <USD>50.25</USD>
            </result>
         EOS

         FakeWeb.register_uri :post, TM4B::Client::BaseURI.dup, :body => @success_response
      end

      it "should request a balance returning a receipt" do
         client = TM4B::Client.new

         result = client.check_balance

         result.should be_a TM4B::BalanceCheck

         result.balance.should == {"USD" => 50.25}
      end

      it 'should raise a service error when receiving an error response' do
         response = OpenStruct.new(:body => "error(0002|Invalid Username or Password)")

         client = TM4B::Client.new
         client.should_receive(:request).and_return response

         lambda do
            client.check_balance
         end.should raise_error TM4B::ServiceError, "The account's credentials could not be verified"
      end
   end
end