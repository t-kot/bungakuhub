require "spec_helper"

describe BranchesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/repositories/1/branches").should route_to("branches#index", user_id: "User1", repository_id: "1")
    end

    it "routes to #show" do
      get("/users/User1/repositories/1/branches/1").should route_to("branches#show", :id => "1", user_id:"User1", repository_id:"1")
    end

  end
end
