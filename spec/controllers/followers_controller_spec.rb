require 'spec_helper'

describe FollowersController do
  let(:user){ mock_model(User, id:1)}
  let(:followers){ [mock_model(User)]}
  before do
    User.should_receive(:find).with("1").and_return(user)
    user.stub(:followers).and_return followers
  end

  describe "GET index" do
    it "should assign the requested user as @user" do
      get :index, {user_id:user}
      assigns(:user).should eq user
    end
    it "should assigns the requested followers as @followers" do
      get :index, {user_id:user}
      assigns(:followers).should eq followers
    end
  end

end
