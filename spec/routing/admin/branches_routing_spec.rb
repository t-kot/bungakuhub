require "spec_helper"

describe Admin::BranchesController do
  describe "routing" do

    it "routes to #new" do
      get("/admin/branches/1/checkout/new").should route_to("admin/branches#new", branch_id:"1")
    end

    it "routes to #create" do
      post("/admin/branches/1/checkout").should route_to("admin/branches#create", branch_id:"1")
    end

    it "routes to #destroy" do
      delete("/admin/branches/1").should route_to("admin/branches#destroy", :id => "1")
    end

  end
end
