require "spec_helper"

describe Admin::KommitsController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/admin/repositories/1/branches/1/kommits").should route_to("admin/kommits#index",user_id:"User1", repository_id:"1", branch_id:"1")
    end

    it "routes to #new" do
      get("/users/User1/admin/repositories/1/branches/1/kommits/new").should route_to("admin/kommits#new", user_id:"User1", repository_id:"1", branch_id:"1")
    end

    it "routes to #show" do
      get("/users/User1/admin/repositories/1/branches/1/kommits/1").should route_to("admin/kommits#show", :id => "1", user_id:"User1", repository_id:"1", branch_id:"1")
    end

    it "routes to #create" do
      post("/users/User1/admin/repositories/1/branches/1/kommits").should route_to("admin/kommits#create",user_id:"User1", repository_id:"1", branch_id:"1")
    end

    it "routes to #destroy" do
      delete("/users/User1/admin/repositories/1/branches/1/kommits/1").should route_to("admin/kommits#destroy", :id => "1", user_id:"User1", repository_id:"1", branch_id:"1")
    end

  end
end
