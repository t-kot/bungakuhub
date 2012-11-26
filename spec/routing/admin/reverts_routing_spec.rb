require 'spec_helper'

describe Admin::RevertsController do
  describe "routing" do

    it "routes to #create" do
      post("/admin/branches/1/kommits/1/revert").should route_to("admin/reverts#create", branch_id:"1", kommit_id:"1")
    end

  end
end
