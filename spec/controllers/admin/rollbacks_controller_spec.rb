require 'spec_helper'
describe Admin::RollbacksController do
  before do
    @branch = mock_model(Branch, id:1)
    @kommit = mock_model(Kommit, id:2)
    @branch.stub(:enter).and_yield
    @branch.stub(:nothing_to_commit?).and_return true
    Branch.should_receive(:find).twice.with("1").and_return(@branch)
    Kommit.should_receive(:find).with("2").and_return(@kommit)
    @branch.should_receive(:rollback_to).with(@kommit)
  end

  describe "POST create" do
    it "redirects to admin_branch_posts_path" do
      post :create, {branch_id:@branch, kommit_id:@kommit}
      response.should redirect_to admin_branch_posts_path(@branch)
    end

    it "render flash rollback success" do
      post :create, {branch_id:@branch, kommit_id:@kommit}
      flash[:notice].should eq I18n.t("flash.info.rollback.success")
    end
  end
end
