require 'spec_helper'

describe Admin::FilesController do
  let(:kommit){ mock_model(Kommit, id:1).as_null_object}
  let(:branch){ mock_model(Branch, id:1).as_null_object}
  before do
    Kommit.should_receive(:find).with("1").and_return kommit
  end

  describe "GET index" do

    it "assigns the requested kommit as @kommit" do
      get :index, {kommit_id: kommit, branch_id: branch}
      assigns(:kommit).should eq kommit
    end
  end

  describe "GET show" do
    it "assigns the requested kommit as @kommit" do
      kommit.should_receive(:inspect).with("hoge").and_return "result"
      get :show, {kommit_id: kommit, branch_id: branch, name: "hoge"}
      assigns(:kommit).should eq kommit
    end

    it "assigns the inspected file as @file" do
      kommit.should_receive(:inspect).with("hoge").and_return "result"
      get :show, {kommit_id: kommit, branch_id: branch, name: "hoge"}
      assigns(:file).should eq "result"
    end
  end

  describe "PUT update" do
    let(:post1){ mock_model(Post).as_null_object}
    before do
      Branch.should_receive(:find).with("1").and_return branch
      
      branch.stub_chain(:posts, :find_by_title).and_return post1
      branch.stub(:enter).and_yield
      kommit.stub(:inspect).and_return "hoge"
    end
    it "assign the requested branch as @branch" do
      put :update, {kommit_id: kommit, branch_id: branch, name:"hoge"}
      assigns(:branch).should eq branch
    end
    it "assign the requested kommit as @kommit" do
      put :update, {kommit_id: kommit, branch_id: branch, name:"hoge"}
      assigns(:kommit).should eq kommit
    end

    it "should redirect to post list" do
      put :update, {kommit_id: kommit, branch_id: branch, name:"hoge"}
      response.should redirect_to admin_branch_posts_path(branch)
    end

    it "display flash notice" do
      put :update, {kommit_id: kommit, branch_id: branch, name:"hoge"}
      flash[:notice].should eq I18n.t("flash.info.update.notice", model: I18n.t("activerecord.models.post"))
    end

    context "when post was found" do
      it "should update attributes" do
        post1.should_receive(:update_attributes!)
        put :update, {kommit_id: kommit, branch_id: branch, name:"hoge"}
      end
    end
    context "when post was not found" do
      before do
        branch.stub_chain(:posts, :find_by_title).and_return false
      end
      it "should create post" do
        Post.should_receive(:create!)
        put :update, {kommit_id: kommit, branch_id: branch, name:"hoge"}
      end
    end
  end

end
