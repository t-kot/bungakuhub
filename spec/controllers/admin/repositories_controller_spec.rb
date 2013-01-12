require 'spec_helper'
describe Admin::RepositoriesController do

  def valid_attributes
    {
      type: "TextRepository",
      repository_type_id: 1,
      description: "HOGEHOGE",
      name: "fuga"
    }
  end

  def valid_session
  end

  after do
    @repository.try(:destroy)
  end

  describe "GET index" do
    login_user
    let(:repositories){ [mock_model(Repository).as_null_object] }

    before do
      subject.current_user.stub(:repositories).and_return repositories
    end

    it "assigns all repositories as @repositories" do
      get :index, {user_id: subject.current_user}, valid_session
      assigns(:repositories).should eq(repositories)
    end
  end

  describe "GET show" do
    login_user
    let(:repository){ mock_model(Repository, id:1, owner:subject.current_user).as_null_object }
    before do
      Repository.stub(:find).with("1").and_return repository
    end
    it "assigns the requested repository as @repository" do
      get :show, {user_id: subject.current_user, id: repository}, valid_session
      assigns(:repository).should eq(repository)
    end
  end

  describe "GET edit" do
    login_user
    context "when valid user" do
      let(:repository){ mock_model(Repository, id:1, owner:subject.current_user).as_null_object}
      before do
        Repository.stub(:find).with("1").and_return repository
      end
      it "assigns the requested repository as @repository" do
        get :edit, {user_id:repository.owner, id:repository}, valid_session
        assigns(:repository).should eq(repository)
      end
    end
    context "When invalid user" do
      let(:repository){ mock_model(Repository, id:1, owner:mock_model(User, id:100) ).as_null_object}
      before do
        Repository.stub(:find).with("1").and_return repository
      end
      it "redirects to root" do
        get :edit, {user_id:repository.owner,id:repository}, valid_session
        response.should redirect_to root_path
      end

      it "display flash alert" do
        get :edit, {user_id:repository.owner,id:repository}, valid_session
        flash[:alert].should eq I18n.t("flash.alert.access_denied")
      end
    end
  end


  describe "PUT update" do
    login_user
    before do
      create_repository_for(subject.current_user)
      @repository = @repository.becomes(TextRepository)
    end
    describe "with valid params" do
      it "updates the requested repository" do
        TextRepository.any_instance.should_receive(:update_attributes).with({'name' => 'hogehoge'})
        put :update, {user_id: subject.current_user,:id => @repository, :repository => {'name' => 'hogehoge'}}, valid_session
      end

      it "assigns the requested repository as @repository" do
        put :update, {user_id: subject.current_user, :id => @repository, :repository => valid_attributes}, valid_session
        assigns(:repository).should eq(@repository)
      end

      it "redirects to the repository" do
        put :update, {user_id: subject.current_user, :id => @repository, :repository => valid_attributes}, valid_session
        response.should redirect_to repository_path(@repository)
      end
    end

    describe "with invalid params" do
      it "assigns the repository as @repository" do
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: @repository.user, :id => @repository.to_param, :repository => {:name => ''}}, valid_session
        assigns(:repository).should eq(@repository)
      end

      it "re-renders the 'edit' template" do
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: @repository.user, :id => @repository, :repository => {:name => ''}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    context "When valid user" do
      let(:repository){ mock_model(Repository, id:1, owner:subject.current_user).as_null_object }
      before do
        Repository.stub(:find).with("1").and_return repository
      end
      it "destroys the requested repository" do
        repository.should_receive(:destroy)
        delete :destroy, {user_id: repository.owner,:id => repository}, valid_session
      end

      it "redirects to the repositories list" do
        delete :destroy, {user_id: repository.owner, :id => repository}, valid_session
        response.should redirect_to(user_repositories_url(subject.current_user))
      end
    end
    context "When invalid user" do

      let(:repository){ mock_model(Repository, id:1, owner:mock_model(User, id:100) ).as_null_object}

      before do
        Repository.stub(:find).and_return repository
      end

      it "redirects to root" do
        delete :destroy, {user_id:repository.owner, :id => repository}, valid_session
        response.should redirect_to root_path
      end

      it "display flash alert" do
        delete :destroy, {user_id:repository.owner, :id => repository}, valid_session
        flash[:alert].should eq I18n.t("flash.alert.access_denied")
      end
    end
  end

end
