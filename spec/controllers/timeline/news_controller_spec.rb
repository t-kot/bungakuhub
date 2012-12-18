require 'spec_helper'

describe Timeline::NewsController do
  before do
    @user = create(:user)
    @news = RepositoryCreateNews.create(user_id:@user)
  end

  describe "GET index" do
    login_user
    it "should assigns the requested news as @news " do
      subject.current_user.follow!(@user)
      get :index
      assigns(:news).should eq [@news]
    end
  end
end
