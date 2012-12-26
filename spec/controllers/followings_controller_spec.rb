require 'spec_helper'

describe FollowingsController do

  describe "GET index" do
    let(:user){ mock_model(User, id:1)}
    let(:followings){ [mock_model(User)]}
    before do
      User.should_receive(:find).with("1").and_return(user)
      user.should_receive(:followings).and_return followings
    end
    it "should assign the requested user as @user" do
      get :index, {user_id:user}
      assigns(:user).should eq user
    end

    it "should assign the requested followings as @followings" do
      get :index, {user_id:user}
      assigns(:followings).should eq followings
    end
  end

  describe "POST create" do
    login_user
    let(:user){ mock_model(User, id:1)}
    before do
      User.should_receive(:find).with("1").and_return(user)
    end
    it "should redirect to root_path" do
      post :create, {user_id:user}
      response.should redirect_to root_path
    end

    it "should add following" do
      subject.current_user.should_receive(:follow!).with(user)
      post :create, {user_id:user}
    end
  end

  describe "DELETE destroy" do
    login_user
    let(:user){ mock_model(User, id:1).as_null_object}
    before do
      User.should_receive(:find).with("1").and_return(user)
      subject.current_user.should_receive(:unfollow!).with(user)
    end
    it "should redirect to root_path" do
      delete :destroy, {id: user}
      response.should redirect_to root_path
    end
    it "display flash info" do
      delete :destroy, {id: user}
      flash[:notice].should eq I18n.t("flash.info.destroy.following", user_name: user.display_name)
    end

  end

end
