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
end
