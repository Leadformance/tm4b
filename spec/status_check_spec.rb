require 'spec_helper'

describe TM4B::StatusCheck do
   before do
      @check = TM4B::StatusCheck.new
      @check.sms_id = "FooBar"
      @check.custom = "Baz"
   end

   it "should define parameters for the api" do
      @check.parameters.should == {
         "version" => "2.1",
         "type" => "check_status",
         "smsid" => "FooBar"
      }
   end

   it "should assign result data from a raw xml response body" do
      @check.raw_response = <<-EOS
         <result>
            <report>DELIVRD|0506231153</report>
         </result>
      EOS

      @check.status.should == "DELIVRD"
      @check.timestamp.should == DateTime.civil(2005, 06, 23, 11, 53)
   end

   it "should not assign a timestamp when that portion is blank" do
      @check.raw_response = <<-EOS
         <result>
            <report>SUBMITD|</report>
         </result>
      EOS

      @check.status.should == "SUBMITD"
      @check.timestamp.should == nil
   end
end