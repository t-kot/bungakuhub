require 'spec_helper'

describe Feed do

  it "cannot create because Feed is abstract class" do
    lambda{Feed.create}.should raise_error
  end

  describe "Feed.followed_by" do
    before do
      @user = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user.follow!(@user2)
      @feed1 = @user.repository_create_news.create
      @feed2 = @user2.repository_create_news.create
      @feed3 = @user3.repository_create_news.create
    end

    it "should return valid feed" do
      feeds = Feed.followed_by(@user)
      feeds.should include @feed1
      feeds.should include @feed2
    end

      
  end
end
