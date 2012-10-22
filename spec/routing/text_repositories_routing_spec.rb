require "spec_helper"

describe TextRepositoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/users/1/text_repositories").should route_to("text_repositories#index",user_id:"1")
    end

    it "routes to #new" do
      get("/users/1/text_repositories/new").should route_to("text_repositories#new",user_id:"1")
    end

    it "routes to #show" do
      get("/users/1/text_repositories/1").should route_to("text_repositories#show", :id => "1",user_id:"1")
    end

    it "routes to #edit" do
      get("/users/1/text_repositories/1/edit").should route_to("text_repositories#edit", :id => "1",user_id:"1")
    end

    it "routes to #create" do
      post("/users/1/text_repositories").should route_to("text_repositories#create",user_id:"1")
    end

    it "routes to #update" do
      put("/users/1/text_repositories/1").should route_to("text_repositories#update", :id => "1",user_id:"1")
    end

    it "routes to #destroy" do
      delete("/users/1/text_repositories/1").should route_to("text_repositories#destroy", :id => "1",user_id:"1")
    end

  end
end
