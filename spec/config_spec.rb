require 'spec_helper'

describe TM4B do
   it "should have configuration accessible from the module" do
      TM4B.config.should be_a TM4B::Configuration
   end

   it "should allow setting a username and password" do
      TM4B.config.username = "foo"
      TM4B.config.username.should == "foo"

      TM4B.config.password = "bar"
      TM4B.config.password.should == "bar"
   end

   it "should allow setting ssl" do
      TM4B.config.use_ssl = true
      TM4B.config.use_ssl.should be_true
   end

end