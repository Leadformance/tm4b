#coding : utf-8
require 'spec_helper'

describe TM4B::Broadcast do
   before do
      @broadcast = TM4B::Broadcast.new
      @broadcast.recipients = "+1 213 555-0100"
      @broadcast.originator = "tm4btest"
      @broadcast.message = "hello world"
   end
   
   it "should return an encoded string if 'plain' encoding if selected" do
     @broadcast.message = "ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöùúûüýÿ"
     @broadcast.encoding = :plain
     @broadcast.parameters["msg"].should == "AAAAAACEEEEIIIINOOOOOUUUUYaaaaaaceeeeiiiinooooouuuuyy"
   end
   
   it "should return valid string even if it's not UTF8 compliant" do
     @broadcast.message = "\xE2"
     @broadcast.encoding = :plain
     @broadcast.parameters["msg"].should == ""
   end
   
   it "should return valid string even if it's not UTF8 compliant" do
     @broadcast.message = "\xE2"
     @broadcast.encoding = :unicode
     @broadcast.parameters["msg"].should == ""
   end

   it "should strip nondigits from the recipient" do
      @broadcast.recipients.should == ["12135550100"]
   end

   it "should assign 'plain' as the encoding by default" do
      @broadcast.encoding.should == :plain
   end

   it "should assign :concatenation_graceful as the default splitting method" do
      @broadcast.split_method.should == :concatenation_graceful
   end

   it "should raise an exception when trying to pass an invalid split method" do
      lambda do
         @broadcast.split_method = :foo
      end.should raise_error "invalid splitting method: foo"
   end

   it "should raise an exception if trying to assign an originator of 0 characters" do
      lambda do
         @broadcast.originator = ""
      end.should raise_error "originator must be between 1 and 11 characters long"
   end

   it "should raise an exception when trying to pass an invalid encoding" do
      lambda do
         @broadcast.encoding = :foo
      end.should raise_error "invalid encoding: foo"
   end

   it "should define parameters for the api" do
      @broadcast.recipients = ["+1 (213) 555-0100", "+1 (213) 555-0101"]
      @broadcast.route = "foo"
      @broadcast.simulated = true

      @broadcast.parameters.should == {
         "version" => "2.1",
         "type" => "broadcast",
         "to" => "12135550100|12135550101",
         "from" => "tm4btest",
         "msg" => "hello world",
         "data_type" => "plain",
         "split_method" => 8,
         "route" => "foo",
         "sim" => "yes"
      }
   end

   it "should assign result data from a raw xml response body" do
      @broadcast.raw_response = <<-EOS
         <result>
            <broadcastID>MT0017295001</broadcastID>
            <recipients>1</recipients>
            <balanceType>GBP</balanceType>
            <credits>5.0</credits>
            <balance>5995.0</balance>
            <neglected>-</neglected>
         </result>
      EOS

      @broadcast.broadcast_id.should == "MT0017295001"
      @broadcast.recipient_count.should == "1"
      @broadcast.balance_type.should == "GBP"
      @broadcast.credits.should == 5
      @broadcast.balance.should == 5995
      @broadcast.neglected.should == "-"
   end
end