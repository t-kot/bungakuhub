require "spec_helper"

describe Admin::TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/text_repositories").should route_to("admin/text_repositories#index")
    end

    it "routes to #edit" do
      get("/admin/text_repositories/1/edit").should route_to("admin/text_repositories#edit", id: "1")
    end
    it "routes to #update" do
      put("/admin/text_repositories/1").should route_to("admin/text_repositories#update", id:"1")
    end
  end
end
