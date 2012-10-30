require "spec_helper"

describe KommitsController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/repositories/1/branches/1//kommits").should route_to("kommits#index", user_id:"User1", repository_id:"1", branch_id:"1")
    end

    it "routes to #show" do
      get("/users/User1/repositories/1/branches/1/kommits/1").should route_to("kommits#show", :id => "1", user_id:"User1", repository_id:"1", branch_id:"1")
    end

  end
end
