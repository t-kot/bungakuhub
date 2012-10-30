require "spec_helper"

describe Home::RepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/repositories").should route_to("home/repositories#index")
    end

  end
end
