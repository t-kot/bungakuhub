require "spec_helper"

describe Users::RepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/repositories").should route_to("users/repositories#index",user_id: "User1")
    end

    it "routes to #show" do
      get("/users/User1/repositories/1").should route_to("users/repositories#show", :id => "1",user_id: "User1")
    end

    it "routes to #edit" do
      get("/users/User1/repositories/1/edit").should route_to("users/repositories#edit", :id => "1",user_id: "User1")
    end

    it "routes to #update" do
      put("/users/User1/repositories/1").should route_to("users/repositories#update", :id => "1",user_id: "User1")
    end

    it "routes to #destroy" do
      delete("/users/User1/repositories/1").should route_to("users/repositories#destroy", :id => "1",user_id: "User1")
    end

  end
end

