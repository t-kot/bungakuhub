require 'spec_helper'

describe Timeline::TweetsController do

  describe "GET index" do
    login_user
    it "should assigns the requested tweets as @tweets" do
      tweets = [double(Tweet)]
      Tweet.should_receive(:followed_by).with(subject.current_user).and_return(tweets)
      get :index
      assigns(:tweets).should eq tweets
    end
  end
end
