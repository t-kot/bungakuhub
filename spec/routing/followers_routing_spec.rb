describe FollowersController do

  describe "routing" do
    
    it "routes to #index" do
      get("/users/1/followers").should route_to("followers#index", user_id:"1")
    end

  end
end
