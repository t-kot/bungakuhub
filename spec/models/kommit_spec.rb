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

  it "should have 2 kommits" do
    @repository.master.should have(3).kommits
  end

  describe "head" do
    it "returns true" do
      @kommit2.head?.should be_true
    end
    it "returns false" do
      @kommit.head?.should be_false
    end
  end


  it "return git message" do
    @kommit.git_message.should == @kommit.message
  end


end
