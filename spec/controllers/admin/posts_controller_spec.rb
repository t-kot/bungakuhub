require 'spec_helper'

describe Admin::PostsController do
  
  def valid_attributes
    {
      title: "Hoge",
      body: "Fuga"
    }
  end

  def valid_session
    {}
  end

  after(:each) do
    @repository.destroy
  end

  describe "GET index" do
    login_user
    it "assigns corresponding posts as @posts" do
      create_repository_for(@current_user)
      @repository.master.posts.create(valid_attributes)
      posts = @repository.master.posts
      get :index, {branch_id: @repository.master}, valid_session
      assigns(:posts).should eq(posts)
    end

    it "assigns new_post as @post" do
      create_repository_for(@current_user)
      get :index, {branch_id: @repository.master}, valid_session
      assigns(:post).should be_a_new(Post)
    end

    it "assigns branch as @branch" do
      create_repository_for(@current_user)
      get :index, {branch_id: @repository.master}, valid_session
      assigns(:branch).should eq(@repository.master)
    end
  end

  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new Post" do
        create_repository_for(@current_user)
        expect {
          post :create, {branch_id: @repository.master, post: valid_attributes}, valid_session
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        create_repository_for(@current_user)
        post :create, {branch_id: @repository.master, post: valid_attributes}, valid_session
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "redirects to the post index" do
        create_repository_for(@current_user)
        post :create, {branch_id: @repository.master, post: valid_attributes}, valid_session
        response.should redirect_to admin_branch_posts_path(@repository.master)
      end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        create_repository_for(@current_user)
        Post.any_instance.stub(:save).and_return(false)
        post :create, {branch_id: @repository.master, post: {}}, valid_session
        assigns(:post).should be_a_new(Post)
      end

      it "re-renders the 'index' template" do
        create_repository_for(@current_user)
        Post.any_instance.stub(:save).and_return(false)
        post :create, {branch_id: @repository.master, post:{}}, valid_session
        response.should render_template("index")
      end

    end
    end
  end

  describe "PUT update" do
    login_user
    describe "with valid params" do
      it "updates the requested post" do
        create_repository_for(@current_user)
        postx = @repository.master.posts.create(title:"hoge", body:"fuga")
        Post.any_instance.should_receive(:update_attributes).with({"title"=> "hoge", "body"=> "FUGA"})
        put :update, {id:postx, post:{title:"hoge", body:"FUGA"}}, valid_session
      end

      it "assigns the requested post as @update_post" do
        create_repository_for(@current_user)
        postx = @repository.master.posts.create(title:"hoge", body:"fuga")
        put :update, {id:postx, post:{title:"hoge", body:"FUGA"}}, valid_session
        assigns(:update_post).should eq(postx)
      end

      it "redirects to the post index" do
        create_repository_for(@current_user)
        postx = @repository.master.posts.create(title:"hoge", body:"fuga")
        put :update, {id:postx, post:{title:"hoge", body:"FUGA"}}, valid_session
        response.should redirect_to admin_branch_posts_path(postx.branch)
      end
    end

    describe "with invalid params" do
      it "assigns the update_post as @update_post" do
        create_repository_for(@current_user)
        postx = create(:post, branch:@repository.master)
        Post.any_instance.stub(:save).and_return(false)
        put :update, {id:postx, post:{}}, valid_session
        assigns(:update_post).should eq(postx)
      end

      it "re-renders the 'index' template" do
        create_repository_for(@current_user)
        postx = create(:post, branch:@repository.master)
        Post.any_instance.stub(:save).and_return(false)
        put :update, {id:postx, post:{}}, valid_session
        response.should render_template("index")
      end
    end

  end

  describe "DELETE destroy" do
    login_user
    it "destroys teh requested post" do
      create_repository_for(@current_user)
      postx = create(:post, branch: @repository.master)
      expect {
        delete :destroy, {id: postx}, valid_session
      }.to change(Post, :count).by(-1)
    end
  end
end
