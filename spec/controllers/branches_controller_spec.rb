require 'spec_helper'

describe BranchesController do
  let(:repository){ mock_model(Repository, id:1)}

  describe "GET index" do
    let(:branches){ [mock_model(Branch)] }
    before do
      repository.stub(:branches).and_return branches
      Repository.should_receive(:find).with("1").and_return(repository)
    end
    it "assigns all branches as @branches" do
      get :index, {repository_id: repository}
      assigns(:branches).should eq branches
    end
  end

  describe "GET show" do
    let(:branch){ mock_model(Branch, id:1) }
    before do
      Branch.should_receive(:find).with("1").and_return(branch)
    end
    it "assigns the requested branch as @branch" do
      get :show, {:id => branch}
      assigns(:branch).should eq(branch)
    end
  end

end
