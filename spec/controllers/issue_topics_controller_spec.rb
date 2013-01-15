require 'spec_helper'

describe IssueTopicsController do
  let(:repository){ mock_model(Repository, id:1).as_null_object}

  describe "GET index" do
    let(:issue_topics){ [mock_model(IssueTopic).as_null_object] }
    before do
      repository.stub(:issue_topics).and_return issue_topics
      Repository.should_receive(:find).with("1").and_return(repository)
    end
    it "assigns requested issue_topics as @issue_topics" do
      get :index, {repository_id: repository}
      assigns(:issue_topics).should eq issue_topics
    end
  end

  describe "GET show" do
    let(:issue_topic){ mock_model(IssueTopic, id:1).as_null_object }
    before do
      issue_topic.stub(:repository).and_return repository
      IssueTopic.should_receive(:find).at_least(1).with("1").and_return issue_topic
    end

    it "should assign the requested issue_topic as @issue_topic" do
      get :show, {id: issue_topic}
      assigns(:issue_topic).should eq issue_topic
    end
  end

  describe "GET new" do
    login_user
    before do
      Repository.should_receive(:find).with("1").and_return repository
    end
    it "assigns a new issue_topic as @issue_topic" do
      get :new, {repository_id: repository}
      assigns(:issue_topic).should be_a_new(IssueTopic)
    end
  end

  describe "POST create" do
    login_user
    let(:issue_topic){ mock_model(IssueTopic).as_null_object }
    before do
      subject.current_user.issue_topics.stub(:build).and_return issue_topic
      Repository.should_receive(:find).with("1").and_return repository
    end
    context "params is valid" do
      before do
        issue_topic.should_receive(:save).and_return true
      end
      it "assigns a newly created issue_topic as @issue_topic" do
        post :create, {repository_id: repository, issue_topic: {} }
        assigns(:issue_topic).should be_instance_of IssueTopic
      end
      it "should redirect to issue_topic path" do
        post :create, {repository_id: repository, issue_topic: {} }
        response.should redirect_to issue_topic_path(issue_topic)
      end
      it "should display flash info" do
        post :create, {repository_id: repository, issue_topic:{}}
        flash[:notice].should eq I18n.t("flash.info.create.notice", model: I18n.t("activerecord.models.issue_topic") )
      end
    end
    context "params is invalid" do
      before do
        issue_topic.should_receive(:save).and_return false
      end
      it "should re-render new template" do
        post :create, {repository_id: repository, issue_topic:{}}
        response.should render_template "new"
      end
    end
  end

  describe "PUT update" do
  end

  describe "DELETE destroy" do
  end
end
