require 'spec_helper'
describe Users::TextRepositoriesController do
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

  describe "GET show" do
    it "assigns the requested text_repository as @text_repository" do
      text_repository = TextRepository.create! valid_attributes
      get :show, {user_id: subject.current_user,:id => text_repository.to_param}, valid_session
      assigns(:text_repository).should eq(text_repository)
    end
  end


  describe "GET edit" do
    it "assigns the requested text_repository as @text_repository" do
      text_repository = TextRepository.create! valid_attributes
      get :edit, {user_id: subject.current_user, :id => text_repository.to_param}, valid_session
      assigns(:text_repository).should eq(text_repository)
    end
  end


  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested text_repository" do
        text_repository = TextRepository.create! valid_attributes
        TextRepository.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested text_repository as @text_repository" do
        text_repository = TextRepository.create! valid_attributes
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => valid_attributes}, valid_session
        assigns(:text_repository).should eq(text_repository)
      end

      it "redirects to the text_repository" do
        text_repository = TextRepository.create! valid_attributes
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => valid_attributes}, valid_session
        response.should redirect_to user_text_repository_path(subject.current_user)
      end
    end

    describe "with invalid params" do
      it "assigns the text_repository as @text_repository" do
        text_repository = TextRepository.create! valid_attributes
        TextRepository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {}}, valid_session
        assigns(:text_repository).should eq(text_repository)
      end

      it "re-renders the 'edit' template" do
        text_repository = TextRepository.create! valid_attributes
        TextRepository.any_instance.stub(:save).and_return(false)
        put :update, {user_id: subject.current_user, :id => text_repository.to_param, :text_repository => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end


end
