require 'spec_helper'

describe Timeline::NewsController do
  describe "routing" do

    it "routes to #index" do
      get("/timeline/news").should route_to("timeline/news#index")
    end

  end
end
