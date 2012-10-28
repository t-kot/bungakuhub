require "spec_helper"

describe RepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/repositories").should route_to("repositories#index")
    end

    it "routes to #new" do
      get("/repositories/new").should route_to("repositories#new")
    end


  end
end
