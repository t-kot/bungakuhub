require 'spec_helper'
describe TextRepositoriesController do

  def valid_attributes
    {
      type: "TextRepository",
      repository_type_id: 1,
      category_id: 1,
      description: "Hello,world",
      name: "samplecode",
      bare: true
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    let(:text_repositories){ [mock_model(TextRepository)]}
    let(:user){ mock_model(User, id:1, text_repositories:text_repositories) }
    before do
      User.should_receive(:find).with("1").and_return(user)
    end
    it "assigns all text_repositories as @text_repositories" do
      get :index,{user_id: user},  valid_session
      assigns(:text_repositories).should eq(text_repositories)
    end
  end

  describe "GET show" do
    let(:text_repository){ mock_model(TextRepository, id:1)}
    before do
      TextRepository.should_receive(:find).with("1").and_return(text_repository)
    end
    it "assigns requested text_repository as @text_repository" do
      get :show, {id: text_repository}
      assigns(:text_repository).should eq text_repository
    end
  end

  describe "GET new" do
    context "When already authenticated" do
      login_user
      it "assigns a new text_repository as @text_repository" do
        get :new, {user_id: subject.current_user}, valid_session
        assigns(:text_repository).should be_a_new(TextRepository)
      end
    end
    context "When not yet authenticated" do
      it "redirects to new session path" do
        get :new, {user_id: 3}, valid_session
        response.should redirect_to new_user_session_path
        flash[:alert].should eq I18n.t("devise.failure.unauthenticated")
      end
    end
  end


  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new TextRepository" do
        expect {
          post :create, {user_id: subject.current_user,:text_repository => valid_attributes}, valid_session
        }.to change(TextRepository, :count).by(1)
        TextRepository.last.destroy
      end

      it "assigns a newly created text_repository as @text_repository" do
        post :create, {user_id: subject.current_user, :text_repository => valid_attributes}, valid_session
        assigns(:text_repository).should be_a(TextRepository)
        assigns(:text_repository).should be_persisted
        TextRepository.last.destroy
      end

      it "redirects to the created text_repository" do
        post :create, {user_id: subject.current_user, :text_repository => valid_attributes}, valid_session
        response.should redirect_to admin_branch_path(TextRepository.last.master)
        TextRepository.last.destroy
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved text_repository as @text_repository" do
        TextRepository.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, :text_repository => {:name => ''}}, valid_session
        assigns(:text_repository).should be_a_new(TextRepository)
      end

      it "re-renders the 'new' template" do
        TextRepository.any_instance.stub(:save).and_return(false)
        post :create, {user_id: subject.current_user, :text_repository => {:name => ''}}, valid_session
        response.should render_template("new")
      end
    end
  end
end
