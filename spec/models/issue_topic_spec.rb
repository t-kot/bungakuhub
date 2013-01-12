require 'spec_helper'

describe IssueTopic do
  before do
    @user = create(:user)
  end

  describe "relation" do
    before do
      @issue_topic = @user.issue_topics.create(body:"hogehoge", title:"fuga")
    end
    it "should return user if called author" do
      @issue_topic.author.should eq @user
    end
  end

  describe "validation" do
    it "should be valid" do
      issue_topic = @user.issue_topics.create(body:"hogehoge", title:"fugafuga")
      issue_topic.should be_valid
    end
    it "should be invalid" do
      issue_topic = @user.issue_topics.create(body:"test", title:"")
      issue_topic.should_not be_valid
    end
  end
end
