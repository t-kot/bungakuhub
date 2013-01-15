require 'spec_helper'


describe KommitsController do

  describe "GET index" do
    let(:branch){ mock_model(Branch, id:1).as_null_object }
    let(:kommits){ [double(Kommit)] }
    before do
      branch.stub(:kommits).and_return kommits
      Branch.should_receive(:find).with("1").and_return branch
    end
    it "assigns all kommits as @kommits" do
      get :index, {branch_id:branch}
      assigns(:kommits).should eq kommits

    end
  end

  describe "GET show" do
    let(:branch){ mock_model(Branch, id:1).as_null_object}
    let(:kommit){ mock_model(Kommit, id:1).as_null_object}
    before do
      Kommit.should_receive(:find).with("1").and_return(kommit)
      Branch.should_receive(:find).with("1").and_return(branch)
    end

    it "assigns the requested kommit as @kommit" do
      get :show, {branch_id:branch, id:kommit}
      assigns(:kommit).should eq kommit
    end

    it "assigns the requested branch as @branch" do
      get :show, {branch_id:branch, id:kommit}
      assigns(:branch).should eq branch
    end
  end
end
