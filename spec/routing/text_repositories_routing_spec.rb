require "spec_helper"

describe TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/text_repositories").should route_to("text_repositories#index")
    end

    it "routes to #new" do
      get("/text_repositories/new").should route_to("text_repositories#new")
    end

    it "routes to #create" do
      post("/text_repositories").should route_to("text_repositories#create")
    end

  end
end
