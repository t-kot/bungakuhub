require "spec_helper"

describe RepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/repositories").should route_to("admin/repositories#index")
    end

    it "routes to #show" do
      get("/admin/repositories/1").should route_to("admin/repositories#show", id: "1")
    end

    it "routes to #edit" do
      get("/admin/repositories/1/edit").should route_to("admin/repositories#edit", id: "1")
    end

    it "routes to #update" do
      put("/admin/repositories/1").should route_to("admin/repositories#update",  id:"1")
    end

    it "routes to #destroy" do
      delete("/admin/repositories/1").should route_to("admin/repositories#destroy",  id:"1")
    end
  end
end
