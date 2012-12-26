require 'spec_helper'

describe Timeline::FeedsController do

  describe "GET index" do
    login_user
    it "should assigns the requested feeds as @feeds" do
      feeds = [double(Feed)]
      Feed.should_receive(:followed_by).with(subject.current_user).and_return(feeds)
      get :index
      assigns(:feeds).should eq feeds
    end
  end

end
