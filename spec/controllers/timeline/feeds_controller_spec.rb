require 'spec_helper'

describe Timeline::FeedsController do
  before do
    @user = create(:user)
    @feed = @user.repository_create_news.create
  end

  describe "GET index" do
    login_user
    it "should assigns the requested feeds as @feeds" do
      subject.current_user.follow!(@user)
      get :index
      assigns(:feeds).should eq [@feed]
    end
  end

end
