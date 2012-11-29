require 'spec_helper'

describe PostObserver do

  before(:each) do
    @user = create(:user)
    create_branch_for(@user)
  end

  after(:each) do
    @repository.destroy
  end


  describe "After Create" do
    it "add index when after create" do
      Post.any_instance.should_receive(:add_index)
      @branch.posts.create(title:"hoge", body:"fuga")
    end
  end

  describe "Before Update" do
    it "should receive add_index" do
      post = @branch.posts.create(title:"hoge", body:"fuga")
      post.should_receive(:add_index)
      post.should_not_receive(:rename)
      post.update_attributes({title:"hoge", body:"hogehoge"})
    end

    it "should rename" do
      post = @branch.posts.create(title:"hoge", body:"fuga")
      post.should_receive(:add_index)
      post.should_receive(:rename)
      post.update_attributes({title:"hogehoge", body:"hogehoge"})
    end
  end

end
