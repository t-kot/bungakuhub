#coding:utf-8
require 'spec_helper'

describe User do
  before do
    @user = User.new(:first_name=>"tanaka", :last_name=>"kakuei")
    @user2 = create(:user)
  end
  it "full_name()でfirst_name+last_nameが返されること" do
    @user.full_name.should == "tanaka kakuei"
  end

  describe "follow!" do
    it "should include the user" do
      @user.follow!(@user2)
      @user.followings.should include(@user2)
    end
    it "should not include the user" do
      @user.followings.should_not include(@user2)
    end
  end

  describe "follows?" do
    it "should return true" do
      @user.follow!(@user2)
      @user.follows?(@user2).should be_true
    end

    it "should return false" do
      @user.follows?(@user2).should be_false
    end
  end
end
