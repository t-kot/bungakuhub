require 'spec_helper'

describe FollowingsController do
  before do
    5.times{|n| eval "@user#{n} = create(:user)"}
    @user1.follow!(@user2)
    @user1.follow!(@user3)
  end

  describe "GET index" do
    it "should assign the requested user as @user" do
      get :index, {user_id:@user1}
      assigns(:user).should eq @user1
    end

    it "should assign the requested followings as @followings" do
      get :index, {user_id:@user1}
      assigns(:followings).should eq [@user2, @user3]
    end
  end

  describe "POST create" do
    login_user
    it "should redirect to root_path" do
      post :create, {user_id:@user1}
      response.should redirect_to root_path
    end

    it "should add following" do
      expect {
        post :create, {user_id:@user1}
      }.to change(subject.current_user.followings, :count).by(1)
    end
  end

  describe "DELETE destroy" do
    login_user
    before do
      subject.current_user.follow!(@user1)
    end
    it "should redirect to root_path" do
      delete :destroy, {id: @user1}
      response.should redirect_to root_path
    end

    it "should remove following" do
      expect {
        delete :destroy, {id:@user1}
      }.to change(subject.current_user.followings, :count).by(-1)
    end
  end

end
