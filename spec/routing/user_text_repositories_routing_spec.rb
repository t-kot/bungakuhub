require "spec_helper"

describe Users::TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/User1/text_repositories").should route_to("users/text_repositories#index",user_id: "User1")
    end

    it "routes to #show" do
      get("/users/User1/text_repositories/1").should route_to("users/text_repositories#show", :id => "1",user_id: "User1")
    end

    it "routes to #edit" do
      get("/users/User1/text_repositories/1/edit").should route_to("users/text_repositories#edit", :id => "1",user_id: "User1")
    end

    it "routes to #update" do
      put("/users/User1/text_repositories/1").should route_to("users/text_repositories#update", :id => "1",user_id: "User1")
    end


  end
end
