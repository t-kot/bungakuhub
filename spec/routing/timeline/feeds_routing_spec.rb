require 'spec_helper'

describe Timeline::FeedsController do
  describe "routing" do

    it "routes to #index" do
      get("/timeline/feeds").should route_to("timeline/feeds#index")
    end
  end
end
