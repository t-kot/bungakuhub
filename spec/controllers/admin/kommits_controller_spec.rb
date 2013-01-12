require 'spec_helper'
describe Admin::KommitsController do

  def valid_attributes
    {
      bare:true,
      message:"First commit",
      revision:"Test"
    }
  end
  def valid_session;{};end

  describe "GET index" do
    login_user
    let(:branch){ mock_model(Branch, id:1).as_null_object}
    let(:kommits){ [mock_model(Kommit).as_null_object] }
    before do
      branch.stub_chain(:repository, :owner).and_return subject.current_user
      branch.stub(:kommits).and_return kommits
      Branch.stub(:find).with("1").and_return(branch)
    end
    it "assigns the requested branch as @branch" do
      get :index, {branch_id:branch}
      assigns(:branch).should eq branch
    end
    it "assigns all kommits as @kommits" do
      get :index, {branch_id:branch}
      assigns(:kommits).should eq kommits
    end
  end

  describe "GET show" do
    login_user

    let(:branch){ mock_model(Branch, id:1).as_null_object}
    let(:kommit){ mock_model(Kommit, id:1).as_null_object}

    before do
      branch.stub_chain(:repository, :owner).and_return subject.current_user
      Branch.stub(:find).with("1").and_return branch
      Kommit.should_receive(:find).with("1").and_return(kommit)
    end

    it "assigns the requested kommit as @kommit" do
      get :show, {:id => kommit, branch_id:branch}, valid_session
      assigns(:kommit).should eq kommit
    end
  end

  describe "GET new" do
    login_user
    let(:branch){ mock_model(Branch, id:1).as_null_object}
    before do
      repository = mock_model(Repository, owner: subject.current_user).as_null_object
      branch.stub(:repository).and_return repository
      branch.stub(:enter).and_yield
      Branch.stub(:find).with("1").and_return(branch)
    end
    it "assigns a new kommit as @kommit" do
      get :new, {branch_id:branch}
      assigns(:kommit).should be_a_new(Kommit)
    end
  end

  describe "POST create" do
    login_user
    let(:branch) {mock_model(Branch, id:1).as_null_object}
    let(:kommit) {mock_model(Kommit).as_null_object.as_new_record}
    before do
      branch.stub_chain(:repository, :owner).and_return subject.current_user
      branch.stub(:nothing_to_commit?).and_return false
      branch.stub(:build_kommit).and_return kommit
      branch.stub(:enter).and_yield
      Branch.stub(:find).with("1").and_return(branch)
    end
    describe "with valid params" do
      before do
      end
      it "creates a new Kommit" do
        kommit.should_receive(:save)
        post :create, {branch_id:branch, kommit:valid_attributes}
      end

      it "redirects to the branch" do
        post :create, {branch_id: branch, kommit: valid_attributes}, valid_session
        response.should redirect_to admin_branch_kommits_path(branch)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved kommit as @kommit" do
        kommit.stub(:save).and_return(false)
        post :create, {branch_id:branch, kommit:{message: '', revision:''}}, valid_session
        assigns(:kommit).should be_a_new(Kommit)
      end

      it "re-renders the 'new' template" do
        kommit.stub(:save).and_return(false)
        post :create, {branch_id:branch, :kommit => {:message => ''}}, valid_session
        response.should render_template("new")
      end
    end

    describe "when nothing to do" do
      before do
        branch.stub(:nothing_to_commit?).and_return true
      end
      it "redirects to back" do
        request.env["HTTP_REFERER"] = root_path
        post :create, {branch_id:branch, kommit:{message:"hogehoge"}}
        response.should redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    let(:branch){ mock_model(Branch, id:1).as_null_object }
    let(:kommit){ mock_model(Kommit, id:1).as_null_object }
    before(:each) do
      branch.stub(:nothing_to_commit?).and_return false
      branch.stub(:enter).and_yield
      branch.stub_chain(:repository, :owner).and_return subject.current_user
      Branch.stub(:find).with("1").and_return(branch)
      Kommit.stub(:find).with("1").and_return(kommit)
    end
    it "destroys requested kommit" do
      kommit.should_receive(:destroy)
      delete :destroy, {id: kommit, branch_id:branch}
    end
    it "redirects to kommit index" do
      delete :destroy, {id: kommit, branch_id:branch}
      response.should redirect_to admin_branch_kommits_url(branch)
    end
  end
end
