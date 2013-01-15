require 'spec_helper'

describe IssueCommentsController do
  let(:issue_topic){ mock_model(IssueTopic, id:1)}

  describe "POST create" do
    login_user
    before do
      IssueTopic.should_receive(:find).with("1").and_return issue_topic
      issue_topic.stub_chain(:issue_comments, :build).and_return IssueComment.new
    end
    context "valid params" do
      before do
        IssueComment.any_instance.should_receive(:save).and_return true
      end
      it "should assigns the created issue_comment as @issue_comment" do
        post :create, {issue_topic_id: issue_topic}
        assigns(:issue_comment).should be_a IssueComment
      end
      it "should redirect to issut_topic_path" do
        post :create, {issue_topic_id: issue_topic}
        response.should redirect_to issue_topic_path(issue_topic)
      end
    end
    context "invalid params" do
      before do
        IssueComment.any_instance.should_receive(:save).and_return false
      end
      it "should display flash alert" do
        post :create, {issue_topic_id: issue_topic}
        flash[:alert].should_not be_nil
      end
    end
  end
end
