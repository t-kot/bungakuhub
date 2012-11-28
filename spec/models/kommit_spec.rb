require 'spec_helper'

describe Kommit do
  before(:each) do
    @user = create(:user)
    create_repository_for(@user)
    @repository.master.posts.create({title:"hoge", body:"fuga"})
    @kommit = build(:kommit, message:"Test")
    @kommit.user = @user
    @kommit.branches << @repository.master
    @kommit.init_at = @repository.master
    @kommit.save
    @repository.master.posts.create({title:"fuga", body:"piyo"})
    @kommit2 = build(:kommit, message:"Second")
    @kommit2.branches << @repository.master
    @kommit2.init_at = @repository.master
    @kommit2.save
    @branch2 = @repository.master.checkout({name:"branch2"})
    @branch2.save
    @branch2.posts.create({title:"piyo", body:"hoge"})
    @branch2.kommits << @repository.master.kommits
    @kommit3 = build(:kommit, message:"Third at branch2")
    @kommit3.branches << @branch2
    @kommit3.init_at = @branch2
    @kommit3.save
  end
  after(:each) do
    @repository.destroy
  end

  it "return repository" do
    @kommit.repository.becomes(Repository).should == @repository
  end

  it "return info" do
    @kommit.info.should be_instance_of(Grit::Commit)
  end

  it "should return kommit count" do
    @repository.master.should have(3).kommits
    @branch2.should have(4).kommits
  end

  describe "head" do
    it "returns true" do
      @kommit2.head?.should be_true
      @kommit3.head?("branch2").should be_true
    end
    it "returns false" do
      @kommit.head?.should be_false
      @kommit2.head?("branch2").should be_false
    end
  end


  it "return git message" do
    @kommit.git_message.should == @kommit.message
  end

  describe "original" do
    it "should return original branch" do
      @branch2.original.should eq @repository.master
    end

    it "should return nil" do
      @repository.master.original.should be_nil
    end
  end



end
