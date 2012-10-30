require 'spec_helper'

describe Branch do
  it "should be valid" do
    repository = FactoryGirl.create(:repository)
    branch = repository.branches.create(name: "master")
    branch.should be_valid
  end
  it "should be invalid" do
    repository = FactoryGirl.create(:repository)
    branch = repository.branches.create(name: "")
    branch.should be_invalid
  end
end
