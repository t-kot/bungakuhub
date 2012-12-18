describe FollowingsController do

  describe "routing" do

    it "routes to #index" do
      get("/users/1/followings").should route_to("followings#index", user_id:"1")
    end

    it "routes to #create" do
      post("/users/1/followings").should route_to("followings#create", user_id:"1")
    end

    it"routes to #destroy" do
      delete("/followings/1").should route_to("followings#destroy", id:"1")
    end
  end
end
