require "spec_helper"

describe Home::TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/text_repositories").should route_to("home/text_repositories#index")
    end

  end
end

