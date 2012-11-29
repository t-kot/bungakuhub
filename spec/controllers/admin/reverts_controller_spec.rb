require 'spec_helper'

describe Admin::RevertsController do

  before(:each) do
    create_repository_for(subject.current_user)
    post = create(:post, branch:@repository.master)
    @kommit = @repository.master.build_kommit(message:"second")
    @kommit.save
  end
  after(:each) do
    @repository.destroy
  end

  describe "POST create" do
    login_user

    it "assigns a requested kommit as @kommit" do
      post :create, {branch_id:@repository.master, kommit_id:@repository.master.kommits.first}
      assigns(:kommit).should eq @repository.master.kommits.first
    end

    it "invoke revert" do
      Kommit.any_instance.should_receive(:revert).with(@repository.master.name)
      post :create, {branch_id:@repository.master, kommit_id:@repository.master.kommits.first}
    end

    it "renews current post" do
      Branch.any_instance.should_receive(:destroy_all_post)
      Branch.any_instance.should_receive(:create_bare_post_for).with(@repository.master.kommits.first)
      post :create, {branch_id:@repository.master, kommit_id:@repository.master.kommits.first}
    end



    it "redirects to kommit index " do
      post :create, {branch_id:@repository.master, kommit_id:@repository.master.kommits.first}
      response.should redirect_to admin_branch_kommits_path(@repository.master)
    end
  end
end
