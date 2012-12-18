require 'spec_helper'

describe Timeline::TweetsController do
  describe "routing" do

    it "routes to #index" do
      get("/timeline/tweets").should route_to("timeline/tweets#index")
    end
  end
end
