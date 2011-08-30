require 'spec_helper'

describe TM4B::BalanceCheck do
   before do
      @check = TM4B::BalanceCheck.new
   end

   it "should define parameters for the api" do
      @check.parameters.should == {
         "version" => "2.1",
         "type" => "check_balance"
      }
   end

   it "should assign result data from a raw xml response body" do
      @check.raw_response = <<-EOS
         <result>
            <gbp>35.33</gbp>
            <usd>802.11</usd>
         </result>
      EOS

      @check.balance.should == {
         "gbp" => 35.33,
         "usd" => 802.11
      }
   end
end