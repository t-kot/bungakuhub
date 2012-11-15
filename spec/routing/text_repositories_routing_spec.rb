require "spec_helper"

describe TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/text_repositories").should route_to("text_repositories#index", user_id: "User1")
    end

    it "routes to #show" do
      get("/text_repositories/1").should route_to("text_repositories#show", id:"1")
    end

    it "routes to #new" do
      get("/users/User1/text_repositories/new").should route_to("text_repositories#new", user_id:"User1")
    end

    it "routes to #create" do
      post("/users/User1/text_repositories").should route_to("text_repositories#create", user_id:"User1")
    end

  end
end
