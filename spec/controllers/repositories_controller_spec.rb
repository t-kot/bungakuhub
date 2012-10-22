require 'spec_helper'
describe RepositoriesController do
  login_user

  def valid_attributes
    {
      type: "TextRepository",
      user_id: 1,
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
      repository = TextRepository.create(valid_attributes)
      current_user = subject.current_user

      get :index, {user_id: current_user}, valid_session
      assigns(:repositories).should eq([repository])
    end
  end


  describe "GET new" do
    it "assigns a new repository as @repository" do
      current_user = subject.current_user
      get :new, {user_id: current_user}, valid_session
      assigns(:repository).should be_a_new(Repository)
    end
  end
end
