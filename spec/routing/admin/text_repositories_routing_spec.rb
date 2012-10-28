require "spec_helper"

describe Admin::TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/admin/text_repositories").should route_to("admin/text_repositories#index", user_id:"User1")
    end

    it "routes to #edit" do
      get("/users/User1/admin/text_repositories/1/edit").should route_to("admin/text_repositories#edit", user_id:"User1", id: "1")
    end
    it "routes to #update" do
      put("/users/User1/admin/text_repositories/1").should route_to("admin/text_repositories#update", user_id:"User1", id:"1")
    end
  end
end
