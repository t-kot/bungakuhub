require "spec_helper"

describe TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/text_repositories").should route_to("text_repositories#index", user_id: "User1")
    end

    it "routes to #show" do
      get("users/User1/text_repositories/1").should route_to("text_repositories#show", user_id:"User1", id:"1")
    end

    it "routes to #new" do
      get("/text_repositories/new").should route_to("text_repositories#new")
    end

    it "routes to #create" do
      post("/text_repositories").should route_to("text_repositories#create")
    end

  end
end
