require "spec_helper"

describe RepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/admin/repositories").should route_to("admin/repositories#index",user_id:"User1")
    end

    it "routes to #show" do
      get("/users/User1/admin/repositories/1").should route_to("admin/repositories#show", user_id:"User1", id: "1")
    end

    it "routes to #edit" do
      get("/users/User1/admin/repositories/1/edit").should route_to("admin/repositories#edit", user_id:"User1", id: "1")
    end

    it "routes to #update" do
      put("/users/User1/admin/repositories/1").should route_to("admin/repositories#update", user_id:"User1", id:"1")
    end

    it "routes to #destroy" do
      delete("/users/User1/admin/repositories/1").should route_to("admin/repositories#destroy", user_id:"User1", id:"1")
    end
  end
end
