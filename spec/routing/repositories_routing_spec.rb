require "spec_helper"

describe RepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/repositories").should route_to("repositories#index",user_id: "User1")
    end

    it "routes to #new" do
      get("/users/User1/repositories/new").should route_to("repositories#new",user_id: "User1")
    end

    it "routes to #show" do
      get("/users/User1/repositories/1").should route_to("repositories#show", :id => "1",user_id: "User1")
    end

    it "routes to #edit" do
      get("/users/User1/repositories/1/edit").should route_to("repositories#edit", :id => "1",user_id: "User1")
    end

    it "routes to #create" do
      post("/users/User1/repositories").should route_to("repositories#create",user_id: "User1")
    end

    it "routes to #update" do
      put("/users/User1/repositories/1").should route_to("repositories#update", :id => "1",user_id: "User1")
    end

    it "routes to #destroy" do
      delete("/users/User1/repositories/1").should route_to("repositories#destroy", :id => "1",user_id: "User1")
    end

  end
end
