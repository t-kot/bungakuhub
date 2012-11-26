require 'spec_helper'

describe Admin::MergesController do
  describe "routing" do

    it "routes to #create" do
      post("/admin/branches/1/merge").should route_to("admin/merges#create", branch_id:"1")
    end
  end
end
