require 'spec_helper'

describe Admin::MergesController do

  describe "GET new" do
    let(:branch){ mock_model(Branch, id:1).as_null_object}
    let(:targets){ [double(Branch)] }
    before do
      branch.stub(:brothers).and_return targets
      Branch.should_receive(:find).with("1").and_return(branch)
    end

    it "assigns requested branch as @branch" do
      get :new, {branch_id: branch}
      assigns(:branch).should eq branch
    end


    it "assigns targets as @targets" do
      get :new, {branch_id: branch}
      assigns(:targets).should eq targets
    end

  end

  describe "POST create" do
    let(:merging){ mock_model(Branch, id:1).as_null_object}
    let(:merged){ mock_model(Branch, id:2).as_null_object}
    before do
      merging.stub(:enter).and_yield
      Branch.should_receive(:find).with("1").and_return(merging)
      Branch.should_receive(:find).with("2").and_return(merged)
    end

    it "assigns merging branch as @merging_branch" do
      post :create, {branch_id: merging, merge:{target:merged}}
      assigns(:merging_branch).should eq merging
    end

    it "assigns merged branch as @merged_branch" do
      post :create, {branch_id: merging, merge:{target:merged}}
      assigns(:merged_branch).should eq merged
    end

    it "redirects to the merging branch page" do
      post :create, {branch_id: merging, merge:{target:merged}}
      response.should redirect_to branch_path(merging)
    end

    context "status has changes" do
      before do
        merging.stub(:nothing_to_commit?).and_return false
      end
      it "redirects to back" do
        post :create, {branch_id: merging, merge:{target:merged}}
        response.should redirect_to new_admin_branch_merge_path(merging)
      end
      it "displays status has changes flash" do
        post :create, {branch_id: merging, merge:{target:merged}}
        flash[:alert].should eq I18n.t("flash.alert.kommit_to_continue")
      end
    end
  end
end
