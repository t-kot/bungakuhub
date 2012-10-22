require 'spec_helper'
describe TextRepositoriesController do
  login_user

  def valid_attributes
    {
      type: "TextRepository",
      user_id: 1,
      repository_type_id: 1,
      description: "Hello,world",
      name: "sample code"
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all text_repositories as @text_repositories" do
      text_repository = TextRepository.create! valid_attributes
      get :index, {user_id: subject.current_user}, valid_session
      assigns(:text_repositories).should eq([text_repository])
    end
  end

  describe "GET new" do
    it "assigns a new text_repository as @text_repository" do
      get :new, {user_id: subject.current_user}, valid_session
      assigns(:text_repository).should be_a_new(TextRepository)
    end
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new TextRepository" do
        expect {
          post :create, {user_id: subject.current_user,:text_repository => valid_attributes}, valid_session
        }.to change(TextRepository, :count).by(1)
      end

      it "assigns a newly created text_repository as @text_repository" do
        post :create, {user_id: subject.current_user, :text_repository => valid_attributes}, valid_session
        assigns(:text_repository).should be_a(TextRepository)
        assigns(:text_repository).should be_persisted
      end

      it "redirects to the created text_repository" do
        post :create, {user_id: subject.current_user, :text_repository => valid_attributes}, valid_session
        response.should redirect_to user_text_repository_path(subject.current_user,TextRepository.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved text_repository as @text_repository" do
        TextRepository.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, :text_repository => {}}, valid_session
        assigns(:text_repository).should be_a_new(TextRepository)
      end

      it "re-renders the 'new' template" do
        TextRepository.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, :text_repository => {}}, valid_session
        response.should render_template("new")
      end
    end
  end
end
