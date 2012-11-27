require 'spec_helper'

describe Branch do
  it "should be valid" do
    repository = FactoryGirl.create(:repository)
    branch = repository.branches.create(name: "develop")
    branch.should be_valid
    repository.destroy
  end
  it "should be invalid" do
    repository = FactoryGirl.create(:repository)
    branch = repository.branches.create(name: "")
    branch.should be_invalid
    repository.destroy
  end

  describe "checkout" do
    it "returns new branch object" do
      branch = FactoryGirl.create(:branch)
      new_branch = branch.checkout({name:"hoge"})
      new_branch.new_record?.should be_true
      new_branch.should be_an_instance_of(Branch)
    end

    it "has original branch" do
      branch = FactoryGirl.create(:branch)
      new_branch = branch.checkout(name:"hoge")
      new_branch.original_id.should eq branch.id
    end
  end

  describe "original" do
    it "returns branch object" do
      branch = FactoryGirl.create(:branch)
      new_branch = branch.checkout(name:"hoge")
      new_branch.original.should eq branch
    end
  end
end
