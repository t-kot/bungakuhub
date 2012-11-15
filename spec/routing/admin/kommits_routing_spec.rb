require "spec_helper"

describe Admin::KommitsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/branches/1/kommits").should route_to("admin/kommits#index", branch_id:"1")
    end

    it "routes to #new" do
      get("/admin/branches/1/kommits/new").should route_to("admin/kommits#new", branch_id:"1")
    end

    it "routes to #show" do
      get("/admin/branches/1/kommits/1").should route_to("admin/kommits#show", :id => "1", branch_id:"1")
    end

    it "routes to #create" do
      post("/admin/branches/1/kommits").should route_to("admin/kommits#create", branch_id:"1")
    end

    it "routes to #destroy" do
      delete("/admin/branches/1/kommits/1").should route_to("admin/kommits#destroy", :id => "1", branch_id:"1")
    end

  end
end
