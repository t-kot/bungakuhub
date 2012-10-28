#require "spec_helper"
#
#describe BranchesController do
#  describe "routing" do
#
#    it "routes to #index" do
#      get("/users/User1/repositories/1/branches").should route_to("users/branches#index", user_id: "User1", repository_id: "1")
#    end
#
#    it "routes to #new" do
#      get("/users/User1/repositories/1/branches/new").should route_to("users/branches#new", user_id:"User1", repository_id:"1")
#    end
#
#    it "routes to #show" do
#      get("/users/User1/repositories/1/branches/1").should route_to("users/branches#show", :id => "1", user_id:"User1", repository_id:"1")
#    end
#
#
#    it "routes to #create" do
#      post("/users/User1/repositories/1/branches").should route_to("users/branches#create", user_id:"User1", repository_id:"1")
#    end
#
#    it "routes to #destroy" do
#      delete("/users/User1/repositories/1/branches/1").should route_to("users/branches#destroy", :id => "1", user_id:"User1", repository_id:"1")
#    end
#
#  end
#end
