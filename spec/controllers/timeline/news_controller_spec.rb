require 'spec_helper'

describe Timeline::NewsController do

  describe "GET index" do
    login_user
    it "should assigns the requested news as @news " do
      news = [double(News)]
      News.should_receive(:followed_by).with(subject.current_user).and_return(news)
      get :index
      assigns(:feeds).should eq news
    end
  end
end
