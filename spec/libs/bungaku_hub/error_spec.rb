require 'spec_helper'

describe BungakuHub::Error do

  context "when args has error" do
    it "should raise error" do
      stderr = mock(IO)
      stderr.stub(:read).and_return("hogehoge")
      lambda{BungakuHub::Error.new(stderr).try_raise}.should raise_error(BungakuHub::GitError)
    end
  end

  context "when args has no error" do
    it "should not raise error" do
      stderr = mock(IO)
      stderr.stub(:read).and_return("")
      lambda{BungakuHub::Error.new(stderr).try_raise}.should_not raise_error
    end

  end
end
