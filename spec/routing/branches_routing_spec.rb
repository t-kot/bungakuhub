require "spec_helper"

describe BranchesController do
  describe "routing" do

    it "routes to #index" do
      get("/repositories/1/branches").should route_to("branches#index", repository_id: "1")
    end

    it "routes to #show" do
      get("/branches/1").should route_to("branches#show", :id => "1")
    end

  end
end
