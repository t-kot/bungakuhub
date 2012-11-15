require "spec_helper"

describe KommitsController do
  describe "routing" do

    it "routes to #index" do
      get("/branches/1/kommits").should route_to("kommits#index", branch_id:"1")
    end

    it "routes to #show" do
      get("/branches/1/kommits/1").should route_to("kommits#show", :id => "1", branch_id:"1")
    end

  end
end
