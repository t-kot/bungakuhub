require "spec_helper"

describe Admin::BranchesController do
  describe "routing" do

    it "routes to #new" do
      get("/admin/repositories/1/branches/new").should route_to("admin/branches#new", repository_id:"1")
    end

    it "routes to #create" do
      post("/admin/repositories/1/branches").should route_to("admin/branches#create", repository_id:"1")
    end

    it "routes to #destroy" do
      delete("/admin/branches/1").should route_to("admin/branches#destroy", :id => "1")
    end

  end
end
