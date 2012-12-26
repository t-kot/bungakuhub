require 'spec_helper'

describe RepositoryObserver do
  let(:repository){ mock_model(Repository).as_null_object}
  before do
    @observer = RepositoryObserver.instance
  end
  describe "before_create" do
    it "should call mkdir when file not exists" do
      File.stub(:exist?).and_return false
      repository.should_receive(:mkdir)
      @observer.before_create(repository)
    end
    it "should not call mkdir when file exists" do
      File.stub(:exist?).and_return true
      repository.should_not_receive(:mkdir)
      @observer.before_create(repository)
    end
  end

  describe "after_create" do
    let(:branches){ mock_model(Branch).as_null_object}
    let(:branch){ mock_model(Branch).as_null_object}
    before do
      branches.stub(:create).and_return branch
    end
    it "should call git_init" do
      repository.should_receive(:git_init)
      @observer.after_create(repository)
    end

    it "should create master" do
      repository.stub(:branches).and_return branches
      branches.should_receive(:create)
      @observer.after_create(repository)
    end

  end
end
