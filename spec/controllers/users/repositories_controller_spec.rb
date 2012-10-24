require 'spec_helper'
describe Users::RepositoriesController do
  login_user

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
  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET index" do
    it "assigns all repositories as @repositories" do
      user = FactoryGirl.create(:user_with_text_repositories)
      repositories = user.repositories

      get :index, {user_id: user.to_param}, valid_session
      assigns(:repositories).should eq(repositories)
    end
  end

  describe "GET show" do
    it "assigns the requested repository as @repository" do
      #repository = TextRepository.create! valid_attributes
      #current_user = subject.current_user
      user = FactoryGirl.create(:user_with_text_repositories)
      repository = user.repositories.last
      get :show, {user_id: user.to_param, id: repository.to_param}, valid_session
      assigns(:repository).should eq(repository)
    end
  end

  describe "GET edit" do
    it "assigns the requested repository as @repository" do
      #repository = @current_user.text_repositories.create! valid_attributes
      repository = FactoryGirl.create(:repository, user: @current_user).becomes(TextRepository)
      get :edit, {user_id:subject.current_user,id:repository.to_param}, valid_session
      assigns(:repository).should eq(repository)
    end
  end


  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested repository" do
        repository = FactoryGirl.create(:repository, user: @current_user)
        Repository.any_instance.should_receive(:update_attributes).with({'name' => 'hogehoge'})
        put :update, {user_id: subject.current_user,:id => repository.to_param, :repository => {'name' => 'hogehoge'}}, valid_session
      end

      it "assigns the requested repository as @repository" do
        repository = TextRepository.create! valid_attributes
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => valid_attributes}, valid_session
        assigns(:repository).should eq(repository)
      end

      it "redirects to the repository" do
        repository = TextRepository.create! valid_attributes
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => valid_attributes}, valid_session
        response.should redirect_to user_repository_path(subject.current_user,repository)
      end
    end

    describe "with invalid params" do
      it "assigns the repository as @repository" do
        repository = TextRepository.create! valid_attributes
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => {}}, valid_session
        assigns(:repository).should eq(repository)
      end

      it "re-renders the 'edit' template" do
        repository = TextRepository.create! valid_attributes
        Repository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: subject.current_user, :id => repository.to_param, :repository => {name: ''}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested repository" do
      repository = Repository.create! valid_attributes
      expect {
        delete :destroy, {user_id: subject.current_user,:id => repository.to_param}, valid_session
      }.to change(Repository, :count).by(-1)
    end

    it "redirects to the repositories list" do
      repository = Repository.create! valid_attributes
      user = repository.user
      delete :destroy, {user_id: subject.current_user, :id => repository.to_param}, valid_session
      response.should redirect_to(user_repositories_url(user))
    end
  end

end
