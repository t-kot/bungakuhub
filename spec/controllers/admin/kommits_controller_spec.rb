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

  after(:each) do
    @repository.destroy
  end


  describe "GET index" do
    login_user
    it "assigns all kommits as @kommits" do
      create_branch_for(@current_user)
      @branch.kommits.create valid_attributes
      get :index, {user_id:subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommits).should eq(@branch.kommits)
    end
  end

  describe "GET show" do
    login_user
    it "assigns the requested kommit as @kommit" do
      create_branch_for(@current_user)
      kommit = @branch.kommits.create valid_attributes
      get :show, {:id => kommit.to_param, user_id:subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommit).should eq(kommit)
    end
  end

  describe "GET new" do
    login_user
    it "assigns a new kommit as @kommit" do
      create_branch_for(@current_user)
      get :new, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch}, valid_session
      assigns(:kommit).should be_a_new(Kommit)
    end
  end

  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new Kommit" do
        create_branch_for(@current_user)
        expect {
          post :create, {user_id: subject.current_user,repository_id:@repository, branch_id:@branch, kommit:valid_attributes, post:{title:"", body:""}}, valid_session
        }.to change(Kommit, :count).by(1)
      end

      it "redirects to the branch" do
        create_branch_for(@current_user)
        post :create, {user_id: subject.current_user, branch_id: @branch, kommit: valid_attributes, post:{title:"", body:""}}, valid_session
        response.should redirect_to admin_branch_kommits_path(@branch)
      end

      it "create new post" do
        create_branch_for(@current_user)
        expect {
          post :create, {user_id: subject.current_user,repository_id:@repository, branch_id:@branch, kommit:valid_attributes, post:{title:"test", body:"test"}}, valid_session
        }.to change(Post, :count).by(1)
      end

      it "update old post" do
        create_branch_for(@current_user)
        oldpost = FactoryGirl.create(:post, branch: @branch)
        Post.any_instance.should_receive(:update_attributes).with({"title"=>"test", "body"=>"test"})
        post :create, {user_id: subject.current_user,repository_id:@repository, branch_id:@branch, kommit:valid_attributes, "update_posts"=>{oldpost.to_param=>{title:"test", body:"test"}}}, valid_session
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved kommit as @kommit" do
        create_branch_for(@current_user)
        Kommit.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, kommit:{message: '', revision:''}, post:{title:"", body:""}}, valid_session
        assigns(:kommit).should be_a_new(Kommit)
      end
      it "assigns a newly created but unsave new_post as @new_post" do
        create_branch_for(@current_user)
        Kommit.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, kommit:{message: '', revision:''}, post:{title:"hoge", body:"fuga"}}, valid_session

      end

      it "re-renders the 'new' template" do
        create_branch_for(@current_user)
        Kommit.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, repository_id:@repository, branch_id:@branch, :kommit => {:message => ''}, post:{title:"", body:""}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "delete destroy" do
  end
end
