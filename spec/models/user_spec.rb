#coding:utf-8
require 'spec_helper'

describe User do
  before do
    @user = create(:user, first_name:"tanaka", last_name:"kakuei")
    @user2 = create(:user)
  end
  it "User#full_nameでfirst_name+last_nameが返されること" do
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

  describe "unfollow!" do
    it "should remove following" do
      @user.follow!(@user2)
      expect {
        @user.unfollow!(@user2)
      }.to change(@user.followings, :count).by(-1)
    end
    it "should destroy followingship" do
      @user.follow!(@user2)
      FollowingShip.any_instance.should_receive(:destroy)
      @user.unfollow!(@user2)
    end
  end
end
