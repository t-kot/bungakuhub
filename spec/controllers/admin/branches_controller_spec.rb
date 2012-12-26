require 'spec_helper'

describe Admin::BranchesController do

  def valid_attributes
    {
      name: "Branch1"
    }
  end

  def valid_session
    {}
  end


  describe "GET show" do
    login_user
    let(:branch){ mock_model(Branch, id:1).as_null_object}
    before do
      branch.stub_chain(:repository, :owner).and_return(subject.current_user)
      Branch.stub(:find).and_return(branch)
    end
    it "assigns requested branch as @branch" do
      get :show, {id: branch}
      assigns(:branch).should eq branch
    end
  end

  describe "GET new" do
    login_user
    let(:orig_branch){ mock_model(Branch, id:1).as_null_object}
    let(:branch){ mock_model(Branch, id:2).as_null_object.as_new_record}
    before do
      orig_branch.stub_chain(:repository, :owner).and_return(subject.current_user)
      Branch.stub(:find).with("1").and_return(orig_branch)
      Branch.stub(:find).with("2").and_return(branch)
      orig_branch.stub(:nothing_to_commit?).and_return true
    end
    it "assigns a new branch as @branch" do
      get  :new, {branch_id: orig_branch}
      assigns(:branch).should be_a_new(Branch)
    end
    it "assigns a orig branch as @orig_branch" do
      get :new, {branch_id: orig_branch}
      assigns(:orig_branch).should eq orig_branch
    end
  end

  describe "POST create" do
    login_user
    let(:orig_branch){ mock_model(Branch, id:1).as_null_object}
    let(:branch){ mock_model(Branch, id:2, repository:1).as_null_object}
    before do
      orig_branch.stub_chain(:repository, :owner).and_return(subject.current_user)
      Branch.stub(:find).with("1").and_return orig_branch
      orig_branch.stub(:checkout).and_return branch
    end
    describe "with valid params" do
      it "should create new branch" do
        branch.should_receive(:save)
        post :create, {branch_id:orig_branch, branch:valid_attributes}
      end
      it "assigns a newly created branch as @branch" do
        post :create, {branch_id:orig_branch, branch:valid_attributes}
        assigns(:branch).should eq branch
      end


      it "redirects to the created branch" do
        post :create, {branch_id:orig_branch, branch:valid_attributes}
        response.should redirect_to repository_path(branch.repository)
      end
    end

    describe "with invalid params" do
      before do
        branch.should_receive(:save).and_return(false)
      end
      it "assigns a newly created but unsaved branch as @branch" do
        post :create, {branch_id:orig_branch}
        assigns(:branch).should eq branch
      end

      it "re-renders the 'new' template" do
        post :create, {branch_id:orig_branch}
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    let(:branch){ mock_model(Branch, id:1).as_null_object}
    let(:repository){ mock_model(Repository, id:1, owner:subject.current_user)}

    before do
      branch.stub(:repository).and_return repository
      Branch.stub(:find).with("1").and_return branch
    end


    context "try to destroy destroyable" do

      before do
        branch.stub(:destroyable?).and_return true
      end

      it "destroys the requested branch" do
        delete :destroy, {:id => branch}, valid_session
        assigns(:branch).should eq branch
      end

      it "should receive destroy" do
        branch.should_receive(:destroy)
        delete :destroy, {id: branch}
      end

      it "should redirect to repository path" do
        delete :destroy, {id: branch}
        response.should redirect_to repository_path(repository)
      end

      it "should display flash notice" do
        delete :destroy, {id: branch}
        flash[:notice].should eq I18n.t("flash.info.destroy.notice", model: I18n.t("activerecord.models.branch"))
      end
    end

    context "try to destroy master" do

      before do
        branch.stub(:destroyable?).and_return false
      end

      it "redirects to the branches list" do
        delete :destroy, {:id => branch}, valid_session
        response.should redirect_to repository_path(repository)
      end
      it "should display flash alert" do
        delete :destroy, {id: branch}
        flash[:alert].should eq I18n.t("flash.alert.cannot_destroy_branch")
      end
    end
  end

end
