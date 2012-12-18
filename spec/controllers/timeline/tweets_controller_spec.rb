require 'spec_helper'

describe Timeline::TweetsController do
  before do
    @user = create(:user)
    @tweet = @user.tweets.create
  end

  describe "GET index" do
    login_user
    it "should assigns the requested tweets as @tweets" do
      subject.current_user.follow!(@user)
      get :index
      assigns(:tweets).should eq [@tweet]
    end
  end
end
