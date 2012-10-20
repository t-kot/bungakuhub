#coding:utf-8
require 'spec_helper'

describe User do
  before do
    @user = User.new(:first_name=>"tanaka", :last_name=>"kakuei")
  end
  it "full_name()でfirst_name+last_nameが返されること" do
    @user.full_name.should == "tanaka kakuei"
  end
  it "以下は失敗すること" do
    @user.full_name.should == "kakuei tanaka"
  end
end
