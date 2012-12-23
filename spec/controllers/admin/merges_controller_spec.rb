require 'spec_helper'

describe Admin::MergesController do

  before(:each) do
    create_repository_for(subject.current_user)
    create_post_and_kommit_for(@repository.master)
    @another = @repository.master.checkout(name:"another")
    @another.save
    2.times{create_post_and_kommit_for(@another)}
  end

  after(:each) do
    @repository.destroy
  end

  describe "GET new" do


    it "assigns requested branch as @branch" do
      get :new, {branch_id: @repository.master}
      assigns(:branch).should eq @repository.master
    end

    it "assigns targets without the branch itself" do
      targets = @repository.branches - [@repository.master]
      get :new, {branch_id: @repository.master}
      assigns(:targets).should_not include @repository.master
    end

  end

  describe "POST create" do

    it "assigns merging branch as @merging_branch" do
      Branch.any_instance.stub(:merge).and_return(true)
      post :create, {branch_id: @repository.master, merge:{target:@another}}
      assigns(:merging_branch).should eq @repository.master
    end

    it "assigns merged branch as @merged_branch" do
      Branch.any_instance.stub(:merge).and_return(true)
      post :create, {branch_id: @repository.master, merge:{target:@another}}
      assigns(:merged_branch).should eq @another
    end

    context "when merge succeeded" do
      it "redirects to the merging branch page" do
        Branch.any_instance.stub(:merge).and_return(true)
        post :create, {branch_id: @repository.master, merge:{target:@another}}
        response.should redirect_to branch_path(@repository.master)
      end
    end

    #context "when merge failed" do
    #  it "re-renders the 'new' template" do
    #    Branch.any_instance.stub(:merge).and_return(false)
    #    post :create, {branch_id: @repository.master, merge:{target:@another}}
    #    response.should render_template("new")
    #  end
    #end

  end

end
