require 'spec_helper'

describe UsersController do
  describe "routing" do
    it "routes to #show" do
      get("/users/User1").should route_to("users#show", id:"User1")
    end

    it "routes to #edit" do
      get("/users/User1/edit").should route_to("users#edit", id:"User1")
    end

    it "routes to #create" do
      post("/users").should route_to("devise/registrations#create")
    end

    it "routes to #update" do
      put("/users/User1").should route_to("users#update", id:"User1")
    end

    it "routes to #destroy" do
      delete("/users/User1").should route_to("users#destroy", id:"User1")
    end
  end
end
