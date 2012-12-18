require 'spec_helper'

describe FollowersController do
  before do
    5.times{|n| eval "@user#{n} = create(:user)"}
    @user2.follow!(@user1)
    @user3.follow!(@user1)
  end

  describe "GET index" do
    it "should assign the requested user as @user" do
      get :index, {user_id:@user1}
      assigns(:user).should eq @user1
    end
    it "should assigns the requested followers as @followers" do
      get :index, {user_id:@user1}
      assigns(:followers).should eq [@user2, @user3]
    end
  end

end
