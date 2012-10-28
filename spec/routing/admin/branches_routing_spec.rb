require "spec_helper"

describe Admin::BranchesController do
  describe "routing" do

    it "routes to #new" do
      get("/users/User1/admin/repositories/1/branches/new").should route_to("admin/branches#new", user_id:"User1", repository_id:"1")
    end

    it "routes to #create" do
      post("/users/User1/admin/repositories/1/branches").should route_to("admin/branches#create", user_id:"User1", repository_id:"1")
    end

    it "routes to #destroy" do
      delete("/users/User1/admin/repositories/1/branches/1").should route_to("admin/branches#destroy", :id => "1", user_id:"User1", repository_id:"1")
    end

  end
end
