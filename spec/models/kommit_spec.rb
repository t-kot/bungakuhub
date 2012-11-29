require 'spec_helper'

describe Kommit do
  before(:each) do
    @user = create(:user)
    create_repository_for(@user)
    2.times{create_post_and_kommit_for(@repository.master)}
    @kommit = @repository.master.kommits[1]
    @kommit2 = @repository.master.kommits[2]
    @branch2 = @repository.master.checkout({name:"branch2"})
    @branch2.save
    @branch2.kommits << @repository.master.kommits
    1.times{create_post_and_kommit_for(@branch2)}
    @kommit3 = @branch2.kommits.last
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
