require 'spec_helper'

describe DiffsController do
  describe "routing" do

    it "routes to #show" do
      get("branches/1/kommits/1/diffs/2").should route_to("diffs#show", branch_id:"1", kommit_id:"1", id:"2")
    end
  end
end
