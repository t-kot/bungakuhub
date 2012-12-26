require 'spec_helper'

describe BranchObserver do
  let(:branch){ stub_model(Branch)}
  before do
    @observer = BranchObserver.instance
  end
  describe "before_create" do
    it "should call git_branch_create" do
      @observer.should_receive(:git_branch_create)
      branch.bare = false
      @observer.before_create(branch)
    end

    it "should not call git_branch_create" do
      @observer.should_not_receive(:git_branch_create)
      branch.bare = true
      @observer.before_create(branch)
    end
  end
  describe "after_create" do
    before do
      branch.stub(:enter).and_yield
    end

    it "should call create_posts_by_current_file" do
      branch.should_receive(:create_posts_by_current_file)
      @observer.after_create(branch)
    end

    it "should not call create_posts_by_current_file" do
      branch.bare = true
      branch.should_not_receive(:create_posts_by_current_file)
      @observer.after_create(branch)
    end
  end
end
