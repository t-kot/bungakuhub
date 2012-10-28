require "spec_helper"

describe RepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/repositories").should route_to("repositories#index",user_id:"User1")
    end

    it "routes to #show" do
      get("/users/User1/repositories/1").should route_to("repositories#show", user_id:"User1", id: "1")
    end

    it "routes to #new" do
      get("/repositories/new").should route_to("repositories#new")
    end


  end
end
