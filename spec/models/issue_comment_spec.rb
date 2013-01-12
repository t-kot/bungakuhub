require 'spec_helper'

describe IssueComment do
  before do
    @user = create(:user)
    @issue_topic = create(:issue_topic, author:@user)
  end
  describe "relation" do
    before do
      @issue_comment = @user.issue_comments.create(body:"hogehoge", issue_topic_id:@issue_topic)
    end
    it "should return user if called author " do
      @issue_comment.author.should eq @user
    end
    it "should return issue_topic" do
      @issue_comment.issue_topic.should eq @issue_topic
    end
  end

  describe "validation" do
    it "should be valid" do
      issue_comment = @user.issue_comments.create(body:"hogehoge", issue_topic_id:@issue_topic)
      issue_comment.should be_valid
    end

    it "should be invalid if it has no issue_topic_id" do
      issue_comment = @user.issue_comments.create(body:"hogehoge")
      issue_comment.should_not be_valid
    end
  end

end
